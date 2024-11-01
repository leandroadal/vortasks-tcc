package com.leandroadal.vortasks.services.social.tasks;

import java.util.HashSet;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.leandroadal.vortasks.entities.social.tasks.GroupTask;
import com.leandroadal.vortasks.entities.social.tasks.GroupSubtask;
import com.leandroadal.vortasks.entities.social.tasks.dto.grouptask.create.GroupSubtaskCreateDTO;
import com.leandroadal.vortasks.entities.user.User;
import com.leandroadal.vortasks.repositories.social.GroupSubtaskRepository;
import com.leandroadal.vortasks.security.UserSS;
import com.leandroadal.vortasks.services.exception.ForbiddenAccessException;
import com.leandroadal.vortasks.services.exception.ObjectNotFoundException;
import com.leandroadal.vortasks.services.user.UserService;

@Service
public class GroupSubtaskService {

    @Autowired
    private GroupSubtaskRepository repository;

    @Autowired
    private GroupTaskService groupTaskService;

    @Autowired
    private UserService userService;

    @Transactional
    public GroupSubtask createSubTask(String groupTaskId, GroupSubtaskCreateDTO data) {
        UserSS userSS = UserService.authenticated();
        GroupTask groupTask = groupTaskService.getGroupTaskById(groupTaskId);

        if (!groupTask.getAuthor().equals(userSS.getUsername()) && !groupTask.getEditors().contains(userSS.getUsername())) {
            throw new ForbiddenAccessException(
                    "Você não tem permissão para criar tarefas individuais nesta tarefa em grupo.");
        }

        GroupSubtask subTask = new GroupSubtask();
        subTask.setGroupTask(groupTask);

        subTask.setTitle(data.title());
        subTask.setDescription(data.description());
        subTask.setStatus(data.status());
        subTask.setXp(data.xp());
        subTask.setCoins(data.coins());
        subTask.setType(data.type());
        subTask.setRepetition(data.repetition());
        subTask.setReminder(data.reminder());
        subTask.setSkillIncrease(data.skillIncrease());
        subTask.setSkillDecrease(data.skillDecrease());
        subTask.setStartDate(data.startDate());
        subTask.setEndDate(data.endDate());
        subTask.setTheme(data.theme());
        subTask.setDifficulty(data.difficulty());

        // Adiciona os participantes à tarefa individual
        for (String participantUsername : data.participants()) {
            User participant = userService.findUserByUsername(participantUsername);
            subTask.getParticipants().add(participant);
        }

        repository.save(subTask);
        groupTask.getGroupSubtasks().add(subTask);
        groupTaskService.save(groupTask);

        //log.addsubTask(subTask.getId());
        return subTask;
    }

    @Transactional
    public GroupSubtask editSubtask(String groupTaskId, String subtaskId,
            GroupSubtaskCreateDTO data) {
        UserSS userSS = UserService.authenticated();
        GroupTask groupTask = groupTaskService.getGroupTaskById(groupTaskId);
        GroupSubtask subTask = getSubtaskById(subtaskId);

        if (!groupTask.getAuthor().equals(userSS.getUsername()) && !groupTask.getEditors().contains(userSS.getUsername())) {
            throw new ForbiddenAccessException(
                    "Você não tem permissão para editar tarefas individuais nesta tarefa em grupo.");
        }

        subTask.setTitle(data.title());
        subTask.setDescription(data.description());
        subTask.setStatus(data.status());
        subTask.setXp(data.xp());
        subTask.setCoins(data.coins());
        subTask.setType(data.type());
        subTask.setRepetition(data.repetition());
        subTask.setReminder(data.reminder());
        subTask.setSkillIncrease(data.skillIncrease());
        subTask.setSkillDecrease(data.skillDecrease());
        subTask.setStartDate(data.startDate());
        subTask.setEndDate(data.endDate());
        subTask.setTheme(data.theme());
        subTask.setDifficulty(data.difficulty());
        subTask.setFinish(data.finish());
        subTask.setDateFinish(data.dateFinish());

        // Atualiza a lista de participantes
        subTask.getParticipants().clear();
        addParticipantsToSubtask(subTask, data.participants());

        subTask.setSkills(new HashSet<>(data.skills())); 

        repository.save(subTask);

        //log.editIndividualTask(individualTask.getId());
        return subTask;
    }

    @Transactional
    public void deleteSubTask(String groupTaskId, String subTaskId) {
        UserSS userSS = UserService.authenticated();
        GroupTask groupTask = groupTaskService.getGroupTaskById(groupTaskId);
        GroupSubtask subTask = getSubtaskById(subTaskId);

        if (!groupTask.getAuthor().equals(userSS.getUsername()) && !groupTask.getEditors().contains(userSS.getUsername())) {
            throw new ForbiddenAccessException(
                    "Você não tem permissão para excluir tarefas individuais nesta tarefa em grupo.");
        }

        groupTask.getGroupSubtasks().remove(subTask); // Remove a sub tarefa da lista de tarefas da tarefa em grupo
        groupTaskService.save(groupTask); // Salva a tarefa em grupo atualizada

        repository.delete(subTask);
        //log.deleteIndividualTask(individualTask.getId());
    }

    public GroupSubtask getSubtaskById(String id) {
        try {
            return repository.findById(id).orElseThrow(() -> new ObjectNotFoundException(id));
        } catch (Exception e) {
            //log.notFoundIndividualTaskById(id);
            throw e;
        }
    }
    
    @Transactional
    public GroupSubtask save(GroupSubtask individualTask) {
        return repository.save(individualTask);
    }

    private void addParticipantsToSubtask(GroupSubtask subtask, List<String> participants) {
        for (String participantUsername : participants) {
            User participant = userService.findUserByUsername(participantUsername);
            subtask.getParticipants().add(participant);
        }
    }

}