package com.leandroadal.vortasks.entities.backup.userprogress.dto;

import com.leandroadal.vortasks.entities.backup.Backup;
import com.leandroadal.vortasks.entities.backup.userprogress.Goals;

public record GoalsDTO(
    String id, 
    
    Integer dailyProductivity,
    Integer dailyProductivityProgress,

    Integer dailyWellBeing,
    Integer dailyWellBeingProgress,

    Integer weeklyProductivity,
    Integer weeklyProductivityProgress,

    Integer weeklyWellBeing,
    Integer weeklyWellBeingProgress) {

    public GoalsDTO(Goals goals) {
        this(
            goals.getId(), 

            goals.getDailyProductivity(), 
            goals.getDailyProductivityProgress(),

            goals.getDailyWellBeing(),
            goals.getDailyWellBeingProgress(),

            goals.getWeeklyProductivity(), 
            goals.getWeeklyProductivityProgress(),

            goals.getWeeklyWellBeing(),
            goals.getWeeklyWellBeingProgress());
    }

    public Goals toGoals(Backup backup) {
        return new Goals(
            this.id,

            this.dailyProductivity,
            this.dailyProductivityProgress,

            this.dailyWellBeing,
            this.dailyWellBeingProgress,

            this.weeklyProductivity,
            this.weeklyProductivityProgress,

            this.weeklyWellBeing,
            this.weeklyWellBeingProgress,
            
            backup
        );
    }
}
