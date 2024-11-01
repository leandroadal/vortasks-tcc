package com.leandroadal.vortasks.entities.social.tasks.dto.grouptask;

import java.time.Instant;

import com.leandroadal.vortasks.entities.social.tasks.GroupTaskInvite;
import com.leandroadal.vortasks.entities.social.tasks.enums.InviteStatus;

public record GroupTaskInviteDTO(
    String id,
    String groupTaskId,
    String userId,      
    InviteStatus status,
    Instant createdAt
) {
    public GroupTaskInviteDTO(GroupTaskInvite invite) {
        this(
            invite.getId(),
            invite.getGroupTask().getId(), // Obtém o ID da tarefa em grupo
            invite.getUser().getId(),      // Obtém o ID do usuário
            invite.getStatus(),
            invite.getCreatedAt()
        );
    }
}
