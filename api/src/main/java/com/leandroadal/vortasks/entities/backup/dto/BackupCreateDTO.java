package com.leandroadal.vortasks.entities.backup.dto;

import java.time.Instant;
import java.util.List;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.leandroadal.vortasks.entities.backup.userprogress.dto.create.TaskCreateDTO;
import com.leandroadal.vortasks.entities.backup.Backup;
import com.leandroadal.vortasks.entities.backup.userprogress.dto.create.AchievementCreateDTO;
import com.leandroadal.vortasks.entities.backup.userprogress.dto.create.CheckInCreateDTO;
import com.leandroadal.vortasks.entities.backup.userprogress.dto.create.GoalHistoryCreateDTO;
import com.leandroadal.vortasks.entities.backup.userprogress.dto.create.GoalsCreateDTO;
import com.leandroadal.vortasks.entities.backup.userprogress.dto.create.SkillCreateDTO;

public record BackupCreateDTO(
        List<CheckInCreateDTO> checkIns,
        GoalsCreateDTO goals,

        @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd'T'HH:mm:ss'Z'", timezone = "UTC")
        Instant lastModified,
        
        List<AchievementCreateDTO> achievements,
        List<TaskCreateDTO> tasks,
        List<SkillCreateDTO> skills,
        List<GoalHistoryCreateDTO> goalHistory) {

        public Backup toBackup() {
        Backup backup = new Backup(lastModified); // Cria o Backup com lastModified

        backup.setCheckIns(checkIns.stream().map(checkInDTO -> checkInDTO.toCheckIn(backup)).toList());
        backup.setGoals(goals.toGoals(backup));
        backup.setAchievements(achievements.stream().map(ach -> ach.toAchievement(backup)).toList());
        backup.setTasks(tasks.stream().map(task -> task.toTask(backup)).toList());
        backup.setSkills(skills.stream().map(skill -> skill.toSkill(backup)).toList());
        backup.setGoalHistory(goalHistory.stream().map(gh -> gh.toGoalHistory(backup)).toList());

        return backup;
    }
}
