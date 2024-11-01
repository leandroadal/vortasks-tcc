package com.leandroadal.vortasks.services.backup;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.leandroadal.vortasks.entities.backup.Backup;
import com.leandroadal.vortasks.entities.backup.userprogress.Achievement;
import com.leandroadal.vortasks.entities.backup.userprogress.CheckIn;
import com.leandroadal.vortasks.entities.backup.userprogress.GoalHistory;
import com.leandroadal.vortasks.entities.backup.userprogress.Goals;
import com.leandroadal.vortasks.entities.backup.userprogress.Skill;
import com.leandroadal.vortasks.entities.backup.userprogress.Task;
import com.leandroadal.vortasks.entities.backup.userprogress.dto.AchievementDTO;
import com.leandroadal.vortasks.entities.user.User;
import com.leandroadal.vortasks.repositories.backup.BackupRepository;
import com.leandroadal.vortasks.security.UserSS;
import com.leandroadal.vortasks.services.backup.exceptions.BackupCreationException;
import com.leandroadal.vortasks.services.exception.ObjectNotFoundException;
import com.leandroadal.vortasks.services.user.UserService;

@Service
public class BackupService {

    @Autowired
    private UserService userService;

    @Autowired
    private BackupRepository backupRepository;

    @Autowired
    private BackupAssociationService backupAssociation;

    @Autowired
    private LogBackupService logService;

    public Backup getBackupByUserId(String userId) {
        try {
            return backupRepository.findByUserId(userId)
                    .orElseThrow(() -> new ObjectNotFoundException(userId));
        } catch (ObjectNotFoundException e) {
            logService.logGetBackupByUserId(userId);
            throw e;
        }
    }

    public Backup createBackup(Backup backup) {
        UserSS userSS = UserService.authenticated();
        User user = userService.findUserById(userSS.getId());
        validateBackupCreation(user);

        try {
            // Associa as skills às tasks e missions
            backup.getTasks().forEach(task -> associateSkillsToTask(task, backup.getSkills()));


            backupAssociation.linkUserAndBackup(user, backup);
            saveBackup(backup);

            logService.logBackupCreationSuccess(user);
            return backup;
        } catch (Exception e) {
            e.printStackTrace();
            logService.logBackupCreationFailure(user);
            throw new BackupCreationException("Falha ao criar o backup", e);
        }
    }

    private void associateSkillsToTask(Task task, List<Skill> backupSkills) {
        List<Skill> associatedSkills = new ArrayList<>();
        for (Skill skillToAssociate : task.getSkills()) {
            // Encontra a skill correspondente na lista de skills do backup
            Optional<Skill> existingSkill = backupSkills.stream()
                    .filter(s -> s.getName().equals(skillToAssociate.getName()))
                    .findFirst();

            // Adiciona a skill do backup à lista de skills da task
            existingSkill.ifPresent(associatedSkills::add);
        }
        task.setSkills(associatedSkills);
    }

    public Backup getBackup() {
        UserSS userSS = UserService.authenticated();
        return getBackupByUserId(userSS.getId());
    }

    @Transactional
    public Backup updateBackup(Backup data) {
        UserSS userSS = UserService.authenticated();
        Backup existingBackup = getBackupByUserId(userSS.getId());

        // Atualiza os dados do backup
        updateData(existingBackup, data);

        // Associa as skills após atualizar tasks e missions
        existingBackup.getTasks().forEach(task -> associateSkillsToTask(task, existingBackup.getSkills()));

        saveBackup(existingBackup);
        logService.logBackupUpdateSuccess(existingBackup.getId());
        return existingBackup;
    }

    @Transactional
    public void deleteUserBackup() {
        UserSS userSS = UserService.authenticated();
        Backup userBackup = getBackupByUserId(userSS.getId());

        backupAssociation.removeReferences(userBackup);
        deleteBackup(userBackup);
        logService.logBackupDeletionSuccess(userSS.getId());
    }

    private void validateBackupCreation(User user) {
        if (user.getBackup() != null) {
            throw new BackupCreationException("Backup já existe para o usuário com ID:", user.getId());
        }
    }

    private void updateData(Backup existingBackup, Backup data) {
        existingBackup.setLastModified(data.getLastModified());

        updateCheckIns(existingBackup, data.getCheckIns());
        updateGoals(existingBackup.getGoals(), data.getGoals());
        updateAchievements(existingBackup, data.getAchievements());
        updateTasks(existingBackup, data.getTasks());
        updateSkills(existingBackup, data.getSkills());
        updateGoalHistory(existingBackup, data.getGoalHistory());
    }

    private void updateCheckIns(Backup existingBackup, List<CheckIn> newCheckIns) {
        existingBackup.getCheckIns().clear(); // Limpa a lista existente de CheckIns
        newCheckIns.forEach(checkIn -> {
            checkIn.setBackup(existingBackup); // Associa o CheckIn ao Backup
            existingBackup.getCheckIns().add(checkIn); // Adiciona o CheckIn à lista do Backup
        });
    }

    private void updateGoals(Goals existingGoals, Goals newGoals) {
        if (existingGoals != null && newGoals != null) {
            existingGoals.setDailyProductivity(newGoals.getDailyProductivity());
            existingGoals.setWeeklyProductivity(newGoals.getWeeklyProductivity());

            existingGoals.setDailyProductivityProgress(newGoals.getDailyProductivityProgress());
            existingGoals.setWeeklyProductivityProgress(newGoals.getWeeklyProductivityProgress());

            existingGoals.setDailyWellBeing(newGoals.getDailyWellBeing());
            existingGoals.setWeeklyWellBeing(newGoals.getWeeklyWellBeing());

            existingGoals.setDailyWellBeingProgress(newGoals.getDailyWellBeingProgress());
            existingGoals.setWeeklyWellBeingProgress(newGoals.getWeeklyWellBeingProgress());
        } else if (newGoals != null) {
            newGoals.setUserBackup(existingGoals.getUserBackup());
            existingGoals = newGoals;
        }
    }

    private void updateAchievements(Backup existingBackup, List<Achievement> newAchievements) {
        List<Achievement> existingAchievements = existingBackup.getAchievements();

        // Identifica os itens a serem removidos
        List<Achievement> achievementsToRemove = existingAchievements.stream()
                .filter(existingAchievement -> !newAchievements.stream()
                        .anyMatch(newAchievement -> newAchievement.getId().equals(existingAchievement.getId())))
                .collect(Collectors.toList());

        // Remove os itens do backup
        existingAchievements.removeAll(achievementsToRemove);

        for (Achievement newAchievement : newAchievements) {
            // verifica se o id enviado já existe na lista de conquistas
            Optional<Achievement> existingAchievement = existingAchievements.stream()
                    .filter(a -> a.getId().equals(newAchievement.getId()))
                    .findFirst();

            if (existingAchievement.isPresent()) {
                // Caso exista faz as modificações necessárias
                existingAchievement.get().edit(new AchievementDTO(newAchievement));
            } else {
                // Caso não exista, cria um novo item
                newAchievement.setUserBackup(existingBackup);
                existingAchievements.add(newAchievement);
            }
        }
    }

    private void updateTasks(Backup existingBackup, List<Task> newTasks) {
        List<Task> existingTasks = existingBackup.getTasks();

        // Remove as tasks existentes que não estão na nova lista
        existingTasks.removeIf(
                existingTask -> !newTasks.stream().anyMatch(newTask -> newTask.getId().equals(existingTask.getId())));

        // Adiciona as novas tasks que não existem na lista existente
        newTasks.forEach(newTask -> {
            if (!existingTasks.stream().anyMatch(t -> t.getId().equals(newTask.getId()))) {
                newTask.setUserBackup(existingBackup);
                existingTasks.add(newTask);
            }
        });

        // Atualiza as tasks existentes com os dados da nova lista
        existingTasks.forEach(existingTask -> newTasks.stream()
                .filter(newTask -> newTask.getId().equals(existingTask.getId()))
                .findFirst()
                .ifPresent(newTask -> updateTaskData(existingTask, newTask)));

        // Associa as skills após atualizar as tasks
        newTasks.forEach(task -> associateSkillsToTask(task, existingBackup.getSkills()));
    }

    private void updateTaskData(Task existingTask, Task newTask) {
        existingTask.setTitle(newTask.getTitle());
        existingTask.setDescription(newTask.getDescription());
        existingTask.setStatus(newTask.getStatus());
        existingTask.setXp(newTask.getXp());
        existingTask.setCoins(newTask.getCoins());
        existingTask.setType(newTask.getType());
        existingTask.setRepetition(newTask.getRepetition());
        existingTask.setReminder(newTask.getReminder());
        existingTask.setSkillIncrease(newTask.getSkillIncrease());
        existingTask.setSkillDecrease(newTask.getSkillDecrease());
        existingTask.setStartDate(newTask.getStartDate());
        existingTask.setEndDate(newTask.getEndDate());
        existingTask.setTheme(newTask.getTheme());
        existingTask.setDifficulty(newTask.getDifficulty());
        existingTask.setFinish(newTask.isFinish());
        existingTask.setDateFinish(newTask.getDateFinish());
    }

    private void updateSkills(Backup existingBackup, List<Skill> newSkills) {
        existingBackup.getSkills().removeIf(existingSkill -> !newSkills.stream()
                .anyMatch(newSkill -> newSkill.getName().equals(existingSkill.getName())));

        newSkills.forEach(newSkill -> {
            if (!existingBackup.getSkills().stream().anyMatch(s -> s.getName().equals(newSkill.getName()))) {
                newSkill.setUserBackup(existingBackup);
                existingBackup.getSkills().add(newSkill);
            }
        });

        // Atualiza as skills existentes com os dados da nova lista
        existingBackup.getSkills().forEach(existingSkill -> newSkills.stream()
                .filter(newSkill -> newSkill.getName().equals(existingSkill.getName()))
                .findFirst()
                .ifPresent(newSkill -> {
                    existingSkill.setXp(newSkill.getXp());
                    existingSkill.setLevel(newSkill.getLevel());
                    existingSkill.setThemes(newSkill.getThemes());
                }));
    }

    private void updateGoalHistory(Backup existingBackup, List<GoalHistory> newDailyGoalProgress) {
        existingBackup.getGoalHistory().clear();
        newDailyGoalProgress.forEach(dailyGoal -> {
            dailyGoal.setBackup(existingBackup);
            existingBackup.getGoalHistory().add(dailyGoal);
        });
    }

    private void saveBackup(Backup backup) {
        backupRepository.save(backup);
    }

    private void deleteBackup(Backup backup) {
        backupRepository.delete(backup);
    }
}
