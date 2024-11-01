package com.leandroadal.vortasks.entities.backup.userprogress.dto.create;

import com.leandroadal.vortasks.entities.backup.Backup;
import com.leandroadal.vortasks.entities.backup.userprogress.Achievement;

public record AchievementCreateDTO(
        String title,
        String description,
        Integer coins,
        Integer gems, 
        boolean unlocked) {
    
    public Achievement toAchievement(Backup backup) {
        Achievement achievement = new Achievement();
        achievement.setTitle(title);
        achievement.setDescription(description);
        achievement.setCoins(coins);
        achievement.setGems(gems);
        achievement.setUnlocked(unlocked);
        achievement.setUserBackup(backup);
        return achievement;
    }
}
