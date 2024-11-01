package com.leandroadal.vortasks.entities.backup.userprogress.dto.create;

import com.leandroadal.vortasks.entities.backup.Backup;
import com.leandroadal.vortasks.entities.backup.userprogress.Goals;

public record GoalsCreateDTO(
    Integer dailyProductivity,
    Integer weeklyProductivity,

    Integer dailyProductivityProgress,
    Integer weeklyProductivityProgress,

    Integer dailyWellBeing,
    Integer weeklyWellBeing,

    Integer dailyWellBeingProgress,
    Integer weeklyWellBeingProgress) {

    public Goals toGoals(Backup backup) {
        Goals goals = new Goals();
        goals.setDailyProductivity(dailyProductivity);
        goals.setWeeklyProductivity(weeklyProductivity);

        goals.setDailyProductivityProgress(dailyProductivityProgress);
        goals.setWeeklyProductivityProgress(weeklyProductivityProgress);

        goals.setDailyWellBeing(dailyWellBeing);
        goals.setWeeklyWellBeing(weeklyWellBeing);

        goals.setDailyWellBeingProgress(dailyWellBeingProgress);
        goals.setWeeklyWellBeingProgress(weeklyWellBeingProgress);

        goals.setUserBackup(backup);
        return goals;
    }
}
