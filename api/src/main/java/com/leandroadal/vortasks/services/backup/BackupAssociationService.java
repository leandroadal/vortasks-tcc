package com.leandroadal.vortasks.services.backup;

import org.springframework.stereotype.Service;
import com.leandroadal.vortasks.entities.backup.Backup;
import com.leandroadal.vortasks.entities.user.User;

@Service
public class BackupAssociationService {

    protected void linkUserAndBackup(User user, Backup userBackup) {
        user.setBackup(userBackup);
        userBackup.setUser(user);
    }

    protected void removeReferences(Backup userBackup) {
        removeUserReference(userBackup);
        removeCheckInsReference(userBackup);
        removeGoalsReference(userBackup);
        removeAchievementsReference(userBackup);
        removeTasksReference(userBackup);
        removeSkillsReference(userBackup);
        removeGoalHistoryReference(userBackup);
    }

    private void removeUserReference(Backup userBackup) {
        if (userBackup.getUser() != null) {
            userBackup.getUser().setBackup(null);
        }
    }

    private void removeCheckInsReference(Backup userBackup) {
        if (userBackup.getCheckIns() != null) {
            userBackup.getCheckIns().forEach(checkIn -> checkIn.setBackup(null));
        }
    }

    private void removeGoalsReference(Backup userBackup) {
        if (userBackup.getGoals() != null) {
            userBackup.getGoals().setUserBackup(null);
        }
    }

    private void removeAchievementsReference(Backup userBackup) {
        if (userBackup.getAchievements() != null) {
            userBackup.getAchievements().forEach(achievement -> achievement.setUserBackup(null));
        }
    }

    private void removeTasksReference(Backup userBackup) {
        if (userBackup.getTasks() != null) {
            userBackup.getTasks().forEach(task -> task.setUserBackup(null));
        }
    }

    private void removeSkillsReference(Backup userBackup) {
        if (userBackup.getSkills() != null) {
            userBackup.getSkills().forEach(skill -> skill.setUserBackup(null));
        }
    }

    private void removeGoalHistoryReference(Backup userBackup) {
        if (userBackup.getGoalHistory() != null) {
            userBackup.getGoalHistory().forEach(goals -> goals.setBackup(null));
        }
    }

}
