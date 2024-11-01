package com.leandroadal.vortasks.entities.backup.userprogress.dto;

import java.time.Instant;
import java.util.List;

import com.leandroadal.vortasks.entities.backup.Backup;
import com.leandroadal.vortasks.entities.backup.userprogress.Task;
import com.leandroadal.vortasks.entities.backup.userprogress.enums.Status;
import com.leandroadal.vortasks.entities.backup.userprogress.enums.TaskType;
import com.leandroadal.vortasks.entities.social.tasks.enumerators.Difficulty;
import com.leandroadal.vortasks.entities.social.tasks.enumerators.Theme;

public record TaskDTO(
        String id, 
        Status status,
        String title,
        String description,
        int xp,
        int coins,
        TaskType type,
        int repetition,
        Instant reminder,
        int skillIncrease,
        int skillDecrease,
        Instant startDate,
        Instant endDate,
        Theme theme,
        Difficulty difficulty,
        boolean finish, 
        Instant dateFinish,
        List<SkillDTO> skills) {

    public TaskDTO(Task task) {
        this(
            task.getId(),
            task.getStatus(),
            task.getTitle(),
            task.getDescription(),
            task.getXp(),
            task.getCoins(),
            task.getType(),
            task.getRepetition(),
            task.getReminder(),
            task.getSkillIncrease(),
            task.getSkillDecrease(),
            task.getStartDate(),
            task.getEndDate(),
            task.getTheme(),
            task.getDifficulty(),
            task.isFinish(),
            task.getDateFinish(),
            task.getSkills().stream().map(SkillDTO::new).toList()
        );
    }

    public Task toTask(Backup backup) {
        Task task = new Task();
        task.setId(id);
        task.setStatus(status);
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
        task.setFinish(finish);
        task.setDateFinish(dateFinish);
        task.getSkills().addAll(skills.stream().map(skillDTO -> skillDTO.toSkill(backup)).toList());
        return task;
    }

}
