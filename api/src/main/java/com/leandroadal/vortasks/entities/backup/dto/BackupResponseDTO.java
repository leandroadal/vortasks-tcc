package com.leandroadal.vortasks.entities.backup.dto;

import java.time.Instant;
import java.util.List;
import com.leandroadal.vortasks.entities.backup.Backup;
import com.leandroadal.vortasks.entities.backup.userprogress.dto.TaskDTO;
import com.leandroadal.vortasks.entities.backup.userprogress.dto.AchievementDTO;
import com.leandroadal.vortasks.entities.backup.userprogress.dto.CheckInDTO;
import com.leandroadal.vortasks.entities.backup.userprogress.dto.GoalHistoryDTO;
import com.leandroadal.vortasks.entities.backup.userprogress.dto.GoalsDTO;
import com.leandroadal.vortasks.entities.backup.userprogress.dto.SkillDTO;

public record BackupResponseDTO(
        String id,
        String userId,
        List<CheckInDTO> checkIns,
        GoalsDTO goals,
        Instant lastModified,
        List<AchievementDTO> achievements,
        List<TaskDTO> tasks,
        List<SkillDTO> skills,
        List<GoalHistoryDTO> goalHistory) {

    public BackupResponseDTO(Backup userBackup) {
        this(
                userBackup.getId(),
                userBackup.getUser().getId(),
                userBackup.getCheckIns().stream().map(CheckInDTO::new).toList(),
                new GoalsDTO(userBackup.getGoals()),
                userBackup.getLastModified(),
                userBackup.getAchievements().stream().map(AchievementDTO::new).toList(),
                userBackup.getTasks().stream().map(TaskDTO::new).toList(),
                userBackup.getSkills().stream().map(SkillDTO::new).toList(),
                userBackup.getGoalHistory().stream().map(GoalHistoryDTO::new).toList()
            );
    }

}
