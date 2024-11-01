package com.leandroadal.vortasks.entities.backup.userprogress.dto.create;

import java.time.Instant;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.leandroadal.vortasks.entities.backup.Backup;
import com.leandroadal.vortasks.entities.backup.userprogress.Task;
import com.leandroadal.vortasks.entities.backup.userprogress.enums.Status;
import com.leandroadal.vortasks.entities.backup.userprogress.enums.TaskType;
import com.leandroadal.vortasks.entities.social.tasks.enumerators.Difficulty;
import com.leandroadal.vortasks.entities.social.tasks.enumerators.Theme;

public record TaskCreateDTO(
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

        List<SkillCreateDTO> skills) {

    
    public Task toTask(Backup backup) {
        Task task = new Task();
        task.setTitle(title);
        task.setDescription(description);
        task.setXp(xp);
        task.setCoins(coins);
        task.setType(type);
        task.setRepetition(repetition);
        task.setReminder(reminder);
        task.setSkillIncrease(skillIncrease);
        task.setSkillDecrease(skillDecrease);
        task.setStartDate(startDate);
        task.setEndDate(endDate);
        task.setTheme(theme);
        task.setDifficulty(difficulty);
        task.getSkills().addAll(skills.stream().map(skillCreateDTO -> skillCreateDTO.toSkill(backup)).toList());
        task.setFinish(finish);
        task.setDateFinish(dateFinish);
        task.setStatus(status);
        task.setUserBackup(backup);
        return task;
    }
}
