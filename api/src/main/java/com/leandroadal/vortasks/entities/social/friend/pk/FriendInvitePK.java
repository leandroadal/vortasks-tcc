package com.leandroadal.vortasks.entities.social.friend.pk;

import com.leandroadal.vortasks.entities.user.User;

import jakarta.persistence.Embeddable;
import jakarta.persistence.ManyToOne;
import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Embeddable
@EqualsAndHashCode
public class FriendInvitePK {

    @ManyToOne
    private User senderUser;

    @ManyToOne
    private User receiverUser;

}
