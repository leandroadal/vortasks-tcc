package com.leandroadal.vortasks.services.social.friendship;

import org.springframework.stereotype.Service;

import com.leandroadal.vortasks.entities.social.friend.pk.FriendInvitePK;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class LogFriendService {

    public void notFoundFriendInvite(String senderId, String receiverId) {
        log.warn("Pedido de amizade com ID composto: '"+ senderId +"', '" + receiverId + "' não foi encontrada!");;
    }

    public void cancelFriendInvite(String senderId, String receiverId) {
        log.info("Solicitação de amizade com ID composto: '"+ senderId +"', '" + receiverId + "' foi cancelada com sucesso!");
    }

    public void refusedFriendInvite(FriendInvitePK friendInvitePK) {
        log.info("Solicitação de amizade com ID composto: '"+ friendInvitePK.getSenderUser().getId() + "', '" + friendInvitePK.getReceiverUser().getId() + "' foi recusada com sucesso!");
    }

    public void acceptFriendRequest(FriendInvitePK friendInvitePK) {
        log.info("Solicitação de amizade com ID composto: '"+ friendInvitePK.getSenderUser().getId() +"', '" + friendInvitePK.getReceiverUser().getId() + "' foi aceita com sucesso!");
    }

    public void sendFriendRequest(FriendInvitePK friendInvitePK) {
        log.info("Solicitação de amizade com ID composto: '"+ friendInvitePK.getSenderUser().getId() +"', '" + friendInvitePK.getReceiverUser().getId() + "' foi criada com sucesso!");
    }

    protected void friendReceiverMismatch(FriendInvitePK friendInvitePK, String userId) {
        log.debug("Usuário '{}' incompatível com o usuário receptor requerido na amizade: {}", userId , friendInvitePK);
    }

    protected void findFriendshipById(String id) {
        log.error("A amizade com ID: " + id + "' não foi encontrada!");
    }

    public void deleteFriendship(String id) {
        log.info("A amizade com ID: '"+ id + "' foi deletada com sucesso!");
    }

    public void createFriendship(String id) {
        log.info("A amizade com ID: '"+ id + "' foi criada com sucesso!");;
    }  

}
