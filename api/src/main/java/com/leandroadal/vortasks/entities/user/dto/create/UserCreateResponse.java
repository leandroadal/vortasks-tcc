package com.leandroadal.vortasks.entities.user.dto.create;

import com.leandroadal.vortasks.entities.user.User;

public record UserCreateResponse(
        String userId,
        String progressId,
        String name) {
    public UserCreateResponse(User user) {
        this(
                user.getId(),
                user.getProgressData().getId(),
                user.getName());
    }

}
