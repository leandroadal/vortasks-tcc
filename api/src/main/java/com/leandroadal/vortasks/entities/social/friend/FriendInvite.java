package com.leandroadal.vortasks.entities.social.friend;

import java.time.Instant;
import com.leandroadal.vortasks.entities.social.friend.enums.FriendStatus;
import com.leandroadal.vortasks.entities.social.friend.pk.FriendInvitePK;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@Entity
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(of = "id")
public class FriendInvite {

    @EmbeddedId
    private FriendInvitePK id;

    private Instant requestDate;

    @Enumerated(EnumType.STRING)
    private FriendStatus status;

}
