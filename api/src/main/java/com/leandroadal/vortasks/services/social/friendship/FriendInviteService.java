package com.leandroadal.vortasks.services.social.friendship;

import java.time.Instant;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.leandroadal.vortasks.entities.social.friend.FriendInvite;
import com.leandroadal.vortasks.entities.social.friend.Friendship;
import com.leandroadal.vortasks.entities.social.friend.enums.FriendStatus;
import com.leandroadal.vortasks.entities.social.friend.pk.FriendInvitePK;
import com.leandroadal.vortasks.entities.user.User;
import com.leandroadal.vortasks.repositories.social.FriendInviteRepository;
import com.leandroadal.vortasks.security.UserSS;
import com.leandroadal.vortasks.services.exception.ForbiddenAccessException;
import com.leandroadal.vortasks.services.exception.ObjectNotFoundException;
import com.leandroadal.vortasks.services.social.friendship.exceptions.FriendException;
import com.leandroadal.vortasks.services.user.UserService;

@Service
public class FriendInviteService {

    @Autowired
    private FriendInviteRepository friendInviteRepository;

    @Autowired
    private FriendshipService friendshipService;

    @Autowired
    private UserService userService;

    @Autowired
    private LogFriendService log;

    private void validateSenderReceiverIds(String senderId, String receiverId) {
        if (senderId.equals(receiverId)) {
            throw new FriendException("O remetente e o destinatário devem ser diferentes");
        }
    }

    private void validateUserAuth(String userId, String userId2) {
        UserSS userSS = UserService.authenticated();
        if (!userSS.getId().equals(userId) && !userSS.getId().equals(userId2)) {
            throw new ForbiddenAccessException("Requisição invalida para o usuário");
        }
    }

    public FriendInvite getFriendInviteByUsersId(String senderId, String receiverId) {
        try {
            return friendInviteRepository.findByIdSenderUserIdAndIdReceiverUserId(senderId, receiverId);
        } catch (ObjectNotFoundException e) {
            log.notFoundFriendInvite(senderId, receiverId);
            throw e;
        }
    }

    public List<FriendInvite> friendInvitesForUser() {
        UserSS userSS = UserService.authenticated();
        String userId = userSS.getId();
        List<FriendInvite> invites =  friendInviteRepository.findByIdSenderUserIdOrIdReceiverUserId(userId, userId);
        // Filtra as solicitações com status PENDING
        return invites.stream()
                .filter(invite -> invite.getStatus() == FriendStatus.PENDING)
                .collect(Collectors.toList());
    }

    public FriendInvite sendFriendRequest(String senderId, String receiverUsername) {
        User receiverUser = userService.findUserByUsername(receiverUsername);
        
        validateSenderReceiverIds(senderId, receiverUser.getId());
        validateUserAuth(senderId, receiverUser.getId());
        FriendInvite newInvite = createInvite(senderId, receiverUser.getId());
        log.sendFriendRequest(newInvite.getId());
        return friendInviteRepository.save(newInvite);
    }

    private FriendInvite createInvite(String senderId, String receiverId) {
        User requestingUser = userService.findUserById(senderId);
        User receiverUser = userService.findUserById(receiverId);
        FriendInvite newInvite = new FriendInvite();

        newInvite.setId(new FriendInvitePK(requestingUser, receiverUser));
        validateUniqueFriendship(newInvite);
        newInvite.setRequestDate(Instant.now());
        newInvite.setStatus(FriendStatus.PENDING);

        friendInviteAssociation(requestingUser, receiverUser, newInvite);
        return newInvite;
    }

    private void validateUniqueFriendship(FriendInvite newInvite) {
        if (friendInviteRepository.existsById(newInvite.getId())) {
            throw new FriendException("O convite de amizade com ID: " 
                + newInvite.getId().getSenderUser().getId() 
                + newInvite.getId().getReceiverUser().getId() + "' já existe");
        }
    }

    private void friendInviteAssociation(User requestingUser, User receiverUser, FriendInvite newInvite) {
        requestingUser.getSenderFriendRequests().add(newInvite);
        receiverUser.getReceivedFriendRequests().add(newInvite);
    }

    public Friendship acceptFriendRequest(String senderId, String receiverId) {
        validateSenderReceiverIds(senderId, receiverId);
        FriendInvite invite = getFriendInviteByUsersId(senderId, receiverId);
        validateStatus(invite);
        validateReceiverUser(invite);

        invite.setStatus(FriendStatus.ACCEPTED);

        friendInviteRepository.save(invite);
        log.acceptFriendRequest(invite.getId());
        return friendshipService.createFriendship(invite);
    }    

    private void validateStatus(FriendInvite invite) {
        if (invite.getStatus() == FriendStatus.REJECTED) {
            throw new FriendException("O convite de amizade com ID: " + invite.getId() + "' ja foi rejeitado");
        }
    }

    private void validateReceiverUser(FriendInvite invite) {
        UserSS userSS = UserService.authenticated();
        System.out.println(invite.getId().getReceiverUser().getId());
        System.out.println(userSS.getId());
        System.out.println(invite.getId().getReceiverUser().getId().toString() == userSS.getId().toString());

        if (!invite.getId().getReceiverUser().getId().equals(userSS.getId())) {
            log.friendReceiverMismatch(invite.getId(), userSS.getId());
            throw new ForbiddenAccessException("Usuário incompatível com o usuário requerido na amizade: "+ invite.getId());
        }
    }

    public void refusedFriendInvite(String userId, String friendId) {
        FriendInvite invite = getFriendInviteByUsersId(userId, friendId);
        validateReceiverUser(invite);

        invite.setStatus(FriendStatus.REJECTED);
        friendInviteRepository.save(invite);
        log.refusedFriendInvite(invite.getId());
    }

    public void cancelFriendInvite(String userId, String friendId) {
        FriendInvite request = getFriendInviteByUsersId(userId, friendId);
        validateSenderUser(request);

        request.getId().setReceiverUser(null);;
        request.getId().setSenderUser(null);
        friendInviteRepository.delete(request);
        log.cancelFriendInvite(userId,friendId);
    }

    private void validateSenderUser(FriendInvite invite) {
        UserSS userSS = UserService.authenticated();
        if (invite.getId().getSenderUser().getId()!= userSS.getId()) {
            log.friendReceiverMismatch(invite.getId(), userSS.getId());
            throw new ForbiddenAccessException("Usuário incompatível com o usuário requerido na amizade: "+ invite.getId());
        }
    }

}
