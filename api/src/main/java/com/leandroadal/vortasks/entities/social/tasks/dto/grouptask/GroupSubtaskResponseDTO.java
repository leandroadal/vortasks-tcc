package com.leandroadal.vortasks.entities.social.tasks.dto.grouptask;

import java.time.Instant;
import java.util.List;
import java.util.Set;

import com.leandroadal.vortasks.entities.backup.userprogress.enums.Status;
import com.leandroadal.vortasks.entities.backup.userprogress.enums.TaskType;
import com.leandroadal.vortasks.entities.social.tasks.GroupSubtask;
import com.leandroadal.vortasks.entities.social.tasks.enumerators.Difficulty;
import com.leandroadal.vortasks.entities.social.tasks.enumerators.Theme;

public record GroupSubtaskResponseDTO(
    String id,
    String title,
    String description,
    Status status,
    Integer xp,
    Integer coins,
    TaskType type,
    Integer repetition,
    Instant reminder,
    Integer skillIncrease,
    Integer skillDecrease,
    Instant startDate,
    Instant endDate,
    Theme theme,
    Difficulty difficulty,
    Boolean finish,
    Instant dateFinish,
    Set<String> skills,
    List<String> participants // Usernames dos participantes
) {
    public GroupSubtaskResponseDTO(GroupSubtask groupSubtask) {
        this(
            groupSubtask.getId(),
            groupSubtask.getTitle(),
            groupSubtask.getDescription(),
            groupSubtask.getStatus(),
            groupSubtask.getXp(),
            groupSubtask.getCoins(),
            groupSubtask.getType(),
            groupSubtask.getRepetition(),
            groupSubtask.getReminder(),
            groupSubtask.getSkillIncrease(),
            groupSubtask.getSkillDecrease(),
            groupSubtask.getStartDate(),
            groupSubtask.getEndDate(),
            groupSubtask.getTheme(),
            groupSubtask.getDifficulty(),
            groupSubtask.isFinish(),
            groupSubtask.getDateFinish(),
            groupSubtask.getSkills(),
            groupSubtask.getParticipants().stream().map(user -> user.getUsername()).toList() // Mapeia a lista de participantes
        );
    }
}