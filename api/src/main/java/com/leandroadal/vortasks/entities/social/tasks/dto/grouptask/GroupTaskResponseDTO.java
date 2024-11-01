package com.leandroadal.vortasks.entities.social.tasks.dto.grouptask;

import java.time.Instant;
import java.util.List;
import com.leandroadal.vortasks.entities.social.tasks.GroupTask;

public record GroupTaskResponseDTO(
    String id,
    String title,
    String description,
    String author,
    List<String> editors,
    List<String> participants, // Usernames dos usuários participantes
    Instant createdAt,
    Instant startDate, // Data de início
    Instant endDate,
    boolean finish,
    Instant dateFinish,
    List<GroupSubtaskResponseDTO> groupSubtasks
) {
    public GroupTaskResponseDTO(GroupTask groupTask) {
        this(
            groupTask.getId(),
            groupTask.getTitle(),
            groupTask.getDescription(),
            groupTask.getAuthor(),
            groupTask.getEditors(),
            groupTask.getParticipants().stream().map(user -> user.getUsername()).toList(), // Mapeia a lista de usuários
            groupTask.getCreatedAt(),
            groupTask.getStartDate(), // Mapeia startDate
            groupTask.getEndDate(),
            groupTask.isFinish(),
            groupTask.getDateFinish(),
            groupTask.getGroupSubtasks().stream().map(GroupSubtaskResponseDTO::new).toList() // Mapeia a lista de tarefas individuais
        );
    }
}