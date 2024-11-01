package com.leandroadal.vortasks.entities.social.tasks.dto.grouptask.create;

import java.time.Instant;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.leandroadal.vortasks.entities.backup.userprogress.enums.Status;
import com.leandroadal.vortasks.entities.backup.userprogress.enums.TaskType;
import com.leandroadal.vortasks.entities.social.tasks.enumerators.Difficulty;
import com.leandroadal.vortasks.entities.social.tasks.enumerators.Theme;

public record GroupSubtaskCreateDTO(
    Status status,
        String title,
        String description,
        int xp,
        int coins,
        TaskType type,
        int repetition,

        @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd'T'HH:mm:ss'Z'", timezone = "UTC")
        Instant reminder,

        int skillIncrease,
        int skillDecrease,

        @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd'T'HH:mm:ss'Z'", timezone = "UTC")
        Instant startDate,

        @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd'T'HH:mm:ss'Z'", timezone = "UTC")
        Instant endDate,

        Theme theme,
        Difficulty difficulty,
        boolean finish, 

        @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd'T'HH:mm:ss'Z'", timezone = "UTC")
        Instant dateFinish,

        List<String> skills,
        //@NotEmpty(message = "A lista de participantes não pode estar vazia") 
        List<String> participants // Lista de usernames dos participantes
) {
}
