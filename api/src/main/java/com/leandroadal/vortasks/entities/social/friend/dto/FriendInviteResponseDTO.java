package com.leandroadal.vortasks.entities.social.friend.dto;

import com.leandroadal.vortasks.entities.social.friend.FriendInvite;

public record FriendInviteResponseDTO(
    //String friendInviteId,
    String userId,
    String friendUserId
) {
    public FriendInviteResponseDTO(FriendInvite data) {
        this(
            //data.getId(),
            data.getId().getSenderUser().getId(),
            data.getId().getReceiverUser().getId());
        
    }
    
}
