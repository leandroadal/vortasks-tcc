package com.leandroadal.vortasks.entities.social.friend.dto;

import java.time.Instant;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.leandroadal.vortasks.entities.social.friend.Friendship;

public record FriendshipDTO(
        String id,
        List<UserDTO> users,
        @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd'T'HH:mm:ss'Z'", timezone = "GMT")
        Instant friendshipDate
) {

    public FriendshipDTO(Friendship friend) {
        this(
            friend.getId(),
            friend.getUsers().stream().map(UserDTO::new).toList(),
            friend.getFriendshipDate());
    }

}
