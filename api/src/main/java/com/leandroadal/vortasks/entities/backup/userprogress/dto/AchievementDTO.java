package com.leandroadal.vortasks.entities.backup.userprogress.dto;

import com.leandroadal.vortasks.entities.backup.Backup;
import com.leandroadal.vortasks.entities.backup.userprogress.Achievement;

public record AchievementDTO(String id, String title, String description, Integer coins,
Integer gems, boolean unlocked) {

    public AchievementDTO(Achievement achievement) {
        this(achievement.getId(), achievement.getTitle(), achievement.getDescription(), achievement.getCoins(), achievement.getGems(), achievement.isUnlocked());
    }

    public Achievement toAchievement(Backup backup) {
        return new Achievement(
            this.id,
            title,
            description,
            coins,
            gems,
            unlocked,
            backup
        );
        
    }
}
