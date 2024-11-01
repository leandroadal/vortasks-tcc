package com.leandroadal.vortasks.entities.backup.userprogress.dto;

import java.time.Instant;

import com.leandroadal.vortasks.entities.backup.Backup;
import com.leandroadal.vortasks.entities.backup.userprogress.GoalHistory;
import com.leandroadal.vortasks.entities.backup.userprogress.enums.GoalType;
import com.leandroadal.vortasks.entities.backup.userprogress.enums.TaskType;

public record GoalHistoryDTO(
        String id,
        Instant date,
        Integer weekNumber,
        TaskType type,
        GoalType goalType,
        Integer successes,
        Integer failures) {

    public GoalHistoryDTO(GoalHistory data) {
        this(data.getId(), data.getDate(), data.getWeekNumber(), data.getType(), data.getGoalType(), data.getSuccesses(), data.getFailures());
    }

    public GoalHistory toDailyGoalProgress(Backup backup) {
        GoalHistory progress = new GoalHistory();
        progress.setId(id);
        progress.setDate(date);
        progress.setWeekNumber(weekNumber);
        progress.setType(type);
        progress.setGoalType(goalType);
        progress.setSuccesses(successes);
        progress.setFailures(failures);
        progress.setBackup(backup); // Associa o progresso ao backup
        return progress;
    }
}
