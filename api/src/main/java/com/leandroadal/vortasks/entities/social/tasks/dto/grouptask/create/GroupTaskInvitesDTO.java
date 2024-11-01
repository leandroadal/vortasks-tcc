package com.leandroadal.vortasks.entities.social.tasks.dto.grouptask.create;

import java.util.Set;

import jakarta.validation.constraints.NotEmpty;

public record GroupTaskInvitesDTO(
    @NotEmpty(message = "A lista de usernames para convites não pode estar vazia") Set<String> usernames
) {}