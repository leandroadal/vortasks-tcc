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

public record BackupRequestDTO(
        List<CheckInDTO> checkIns,
        GoalsDTO goals,
        Instant lastModified,
        List<AchievementDTO> achievements,
        List<TaskDTO> tasks,
        List<SkillDTO> skills,
        List<GoalHistoryDTO> goalHistory) {

    public Backup toBackup(Backup backup) {
        mapCheckIns(this.checkIns, backup);
        mapGoals(this.goals, backup);
        backup.setLastModified(this.lastModified);
        mapAchievements(this.achievements, backup);
        mapTasks(this.tasks, backup);
        mapSkills(this.skills, backup);
        mapGoalHistory(this.goalHistory, backup);
        return backup;
    }

    private void mapCheckIns(List<CheckInDTO> dataList, Backup backup) {
        backup.setCheckIns(dataList.stream().map(checkInDTO -> checkInDTO.toCheckIn(backup)).toList());
    }

    private void mapGoals(GoalsDTO data, Backup backup) {
        backup.setGoals(data.toGoals(backup));
    }

    private void mapAchievements(List<AchievementDTO> dataList, Backup backup) {
        backup.setAchievements(dataList.stream().map(ach -> ach.toAchievement(backup)).toList());
    }

    private void mapTasks(List<TaskDTO> dataList, Backup userBackup) {
        userBackup.setTasks(dataList.stream().map(taskDTO -> taskDTO.toTask(userBackup)).toList());
    }

    private void mapSkills(List<SkillDTO> dataList, Backup userBackup) {
        userBackup.setSkills(dataList.stream().map(skillDTO -> skillDTO.toSkill(userBackup)).toList());
    }

    private void mapGoalHistory(List<GoalHistoryDTO> dailyGoalProgressDTOS, Backup backup) {
        backup.setGoalHistory(dailyGoalProgressDTOS.stream()
                .map(dailyGoalProgressDTO -> dailyGoalProgressDTO.toDailyGoalProgress(backup))
                .toList());
    }
    
}