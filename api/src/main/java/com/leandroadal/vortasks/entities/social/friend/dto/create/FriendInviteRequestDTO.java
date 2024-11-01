package com.leandroadal.vortasks.entities.social.friend.dto.create;

import jakarta.validation.constraints.NotBlank;

public record FriendInviteRequestDTO(
        @NotBlank(message = "O id é obrigatório") 
        String userId
        ) {

}
