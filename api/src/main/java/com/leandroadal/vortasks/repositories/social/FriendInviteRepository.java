package com.leandroadal.vortasks.repositories.social;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.leandroadal.vortasks.entities.social.friend.FriendInvite;
import com.leandroadal.vortasks.entities.social.friend.pk.FriendInvitePK;
import com.leandroadal.vortasks.entities.user.User;

public interface FriendInviteRepository extends JpaRepository<FriendInvite, FriendInvitePK> {
    //List<FriendInvite> findByFriendUserAndStatus(User user, FriendStatus status);
    List<FriendInvite> findByIdSenderUserOrIdReceiverUser(User senderUser, User receiverUser);

    List<FriendInvite> findByIdSenderUserIdOrIdReceiverUserId(String senderUser, String receiverUser);

    FriendInvite findByIdSenderUserIdAndIdReceiverUserId(String senderUser, String receiverUser);
}
