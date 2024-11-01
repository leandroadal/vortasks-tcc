package com.leandroadal.vortasks.entities.user.dto;

import com.leandroadal.vortasks.entities.user.User;
import com.leandroadal.vortasks.entities.user.UserRole;

public record UserResponseDTO(
        String userId,
        String progressId,
        String name,
        String email,
        String username,
        UserRole role) {
    public UserResponseDTO(User user) {
        this(
                user.getId(),
                user.getProgressData().getId(),
                user.getName(),
                user.getEmail(),
                user.getUsername(),
                user.getRole());
    }

}
