package com.leandroadal.vortasks.entities.social.friend.dto;

import com.leandroadal.vortasks.entities.user.User;

public record UserDTO(String id, String name, int level, String username) {

    public UserDTO(User user) {
        this(user.getId(), user.getName(), user.getProgressData().getLevel(), user.getUsername());
    }

}
