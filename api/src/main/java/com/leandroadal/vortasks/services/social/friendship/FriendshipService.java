package com.leandroadal.vortasks.services.social.friendship;

import java.time.Instant;
import java.util.List;
import java.util.Optional;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.leandroadal.vortasks.entities.social.friend.FriendInvite;
import com.leandroadal.vortasks.entities.social.friend.Friendship;
import com.leandroadal.vortasks.entities.user.User;
import com.leandroadal.vortasks.repositories.social.FriendshipRepository;
import com.leandroadal.vortasks.security.UserSS;
import com.leandroadal.vortasks.services.exception.ForbiddenAccessException;
import com.leandroadal.vortasks.services.exception.ObjectNotFoundException;
import com.leandroadal.vortasks.services.user.UserService;

@Service
public class FriendshipService {

    @Autowired
    private FriendshipRepository friendshipRepository;

    @Autowired
    private LogFriendService log;

    @Autowired
    private UserService userService;

    public List<Friendship> getFriendshipsByUser() {
        UserSS userSS = UserService.authenticated();
        User user = userService.findUserById(userSS.getId());
        return friendshipRepository.findFriendshipsByUser(user);
    }

    public Friendship findFriendshipById(String id) {
        try {
            return friendshipRepository.findById(id).orElseThrow(() -> new ObjectNotFoundException(id));
        } catch (ObjectNotFoundException e) {
            log.findFriendshipById(id);
            throw e;
        }

    }

    public Friendship createFriendship(FriendInvite request) {
        User sender = request.getId().getSenderUser();
        User receiver = request.getId().getReceiverUser();
        Friendship friendship = new Friendship();
        friendship.setUsers(Set.of(sender, receiver));
        friendship.setFriendshipDate(Instant.now());

        friendshipRepository.save(friendship);

        linkUserToFriendship(sender, receiver, friendship);
        log.createFriendship(friendship.getId());
        return friendship;
    }

    private void linkUserToFriendship(User sender, User receiver, Friendship friendship) {
        sender.getFriendships().add(friendship);
        receiver.getFriendships().add(friendship);
    }

    public void deleteFriendship(String friendshipId) {
        Friendship friendship = findFriendshipById(friendshipId);
        validateUserAuth(friendship);

        friendship.getUsers().forEach(user -> user.getFriendships()
                                                    .remove(friendship));
        friendship.getUsers().clear();

        friendshipRepository.delete(friendship);
        log.deleteFriendship(friendshipId);
    }

    private void validateUserAuth(Friendship friendship) {
        UserSS userSS = UserService.authenticated();
    
        // Verificar se o usuário autenticado está presente na amizade
        boolean userFound = friendship.getUsers().stream()
                                             .anyMatch(user -> user.getId().equals(userSS.getId()));
        if (!userFound) {
            throw new ForbiddenAccessException("Usuário incompatível com o usuário requerido na amizade: "+ friendship.getId());
        }
    }

    public User getFriendData(String friendshipId) {
        Friendship friendship = findFriendshipById(friendshipId);
        validateFriendship(friendship);

        // Obtém o amigo (usuário que NÃO é o usuário autenticado)
        Optional<User> friendOptional = friendship.getUsers().stream()
                .filter(user -> !user.getId().equals(UserService.authenticated().getId()))
                .findFirst();

        return friendOptional.orElseThrow(() -> new ObjectNotFoundException("Amigo não encontrado na amizade"));
    }

    private void validateFriendship(Friendship friendship) {
        UserSS user = UserService.authenticated();;

        if (friendship.getUsers().stream().noneMatch(u -> u.getId().equals(user.getId()))) {
            throw new ForbiddenAccessException("Você não tem permissão para acessar os dados deste amigo.");
        }
    }
}
