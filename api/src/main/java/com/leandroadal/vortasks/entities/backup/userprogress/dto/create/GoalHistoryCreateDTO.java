package com.leandroadal.vortasks.entities.backup.userprogress.dto.create;

import java.time.Instant;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.leandroadal.vortasks.entities.backup.Backup;
import com.leandroadal.vortasks.entities.backup.userprogress.GoalHistory;
import com.leandroadal.vortasks.entities.backup.userprogress.enums.GoalType;
import com.leandroadal.vortasks.entities.backup.userprogress.enums.TaskType;

public record GoalHistoryCreateDTO(
        @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd'T'HH:mm:ss'Z'", timezone = "UTC")
        Instant date,
        Integer weekNumber,
        TaskType type,
        GoalType goalType,
        Integer successes,
        Integer failures) {

    public GoalHistory toGoalHistory(Backup backup) {
        GoalHistory progress = new GoalHistory();
        progress.setDate(date);
        progress.setWeekNumber(weekNumber);
        progress.setType(type);
        progress.setGoalType(goalType);
        progress.setSuccesses(successes);
        progress.setFailures(failures);
        progress.setBackup(backup);
        return progress;
    }
}
