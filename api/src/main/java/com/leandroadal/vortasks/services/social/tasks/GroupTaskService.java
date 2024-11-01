package com.leandroadal.vortasks.services.social.tasks;

import java.time.Instant;
import java.time.ZoneOffset;
import java.util.List;
import java.util.HashSet;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.leandroadal.vortasks.entities.social.tasks.GroupTask;
import com.leandroadal.vortasks.entities.social.tasks.GroupSubtask;
import com.leandroadal.vortasks.entities.social.tasks.dto.grouptask.create.GroupSubtaskCreateDTO;
import com.leandroadal.vortasks.entities.social.tasks.dto.grouptask.create.GroupTaskCreateDTO;
import com.leandroadal.vortasks.entities.user.User;
import com.leandroadal.vortasks.repositories.social.GroupTaskRepository;
import com.leandroadal.vortasks.repositories.social.GroupSubtaskRepository;
import com.leandroadal.vortasks.security.UserSS;
import com.leandroadal.vortasks.services.exception.ForbiddenAccessException;
import com.leandroadal.vortasks.services.exception.ObjectNotFoundException;
import com.leandroadal.vortasks.services.user.UserService;

@Service
public class GroupTaskService {

    @Autowired
    private GroupTaskRepository repository;

    @Autowired
    private GroupSubtaskRepository individualTaskRepository;

    @Autowired
    private UserService userService;

    @Autowired
    private LogSocialTasks log;

    @Transactional
    public GroupTask createGroupTask(GroupTaskCreateDTO data) {
        UserSS userSS = UserService.authenticated();
        User author = userService.findUserById(userSS.getId());

        GroupTask groupTask = data.toGroupTask();
        groupTask.setAuthor(userSS.getUsername());
        groupTask.setCreatedAt(Instant.now());
        groupTask.getParticipants().add(author); // Adiciona o autor à lista de usuários
        repository.save(groupTask);

        // Associa as sub tarefas à tarefa em grupo
        for (GroupSubtaskCreateDTO groupSubtaskDTO : data.groupSubtasks()) {
            GroupSubtask groupSubtask = createSubtaskFromDTO(groupTask, groupSubtaskDTO);
            groupTask.getGroupSubtasks().add(groupSubtask);
        }

        //groupTask.setGroupSubTasks(data.groupSubTasks());
        repository.save(groupTask);

        log.addGroupTask(groupTask.getId());
        return groupTask;
    }

    private GroupSubtask createSubtaskFromDTO(GroupTask groupTask, GroupSubtaskCreateDTO dto) {
        GroupSubtask subtask = new GroupSubtask();
        subtask.setGroupTask(groupTask);
        subtask.setTitle(dto.title());
        subtask.setDescription(dto.description());
        subtask.setStatus(dto.status());
        subtask.setXp(dto.xp());
        subtask.setCoins(dto.coins());
        subtask.setType(dto.type());
        subtask.setRepetition(dto.repetition());
        subtask.setReminder(dto.reminder());
        subtask.setSkillIncrease(dto.skillIncrease());
        subtask.setSkillDecrease(dto.skillDecrease());
        subtask.setStartDate(dto.startDate());
        subtask.setEndDate(dto.endDate());
        subtask.setTheme(dto.theme());
        subtask.setDifficulty(dto.difficulty());

        // Adiciona os participantes à tarefa individual
        for (String participantUsername : dto.participants()) {
            User participant = userService.findUserByUsername(participantUsername);
            subtask.getParticipants().add(participant);
        }

        subtask.setSkills(new HashSet<>(dto.skills()));

        return individualTaskRepository.save(subtask);
    }

    public GroupTask getGroupTaskById(String id) {
        try {
            return repository.findById(id).orElseThrow(() -> new ObjectNotFoundException(id));
        } catch (Exception e) {
            log.notFoundGroupTaskById(id);
            throw e;
        }
    }

    public GroupTask getGroupTaskWithIndividualTasks(String id) {
        try {
            GroupTask groupTask = repository.findById(id).orElseThrow(() -> new ObjectNotFoundException(id));
            // Inicializa a lista SubTasks para evitar LazyInitializationException
            groupTask.getGroupSubtasks().forEach(subtask -> {
                subtask.getSkills().size(); // Força o carregamento das skills
                subtask.getParticipants().size(); // Força o carregamento dos participantes
            }); 
            return groupTask;
        } catch (Exception e) {
            log.notFoundGroupTaskById(id);
            throw e;
        }
    }

    public List<GroupTask> getGroupTasksByUser() {
        UserSS userSS = UserService.authenticated();
        User user = userService.findUserById(userSS.getId());
        return repository.findAllGroupTasksByUser(user);
    }

    public Page<GroupTask> searchGroupTasks(String title, Instant endDate, Pageable pageable) {
        UserSS userSS = UserService.authenticated();
        User authenticatedUser = userService.findUserById(userSS.getId());

        if (endDate != null) {
            // Obtém o início do dia do endDate
            Instant startOfDay = endDate.atZone(ZoneOffset.UTC).toLocalDate().atStartOfDay().toInstant(ZoneOffset.UTC);

            // Obtém o final do dia do endDate
            Instant endOfDay = endDate.atZone(ZoneOffset.UTC).toLocalDate().atTime(23, 59, 59).toInstant(ZoneOffset.UTC);

            // Busca as tarefas que terminam entre o início e o final do dia
            return repository.findByTitleContainingIgnoreCaseAndEndDateBetweenAndParticipantsContaining(title, startOfDay, endOfDay, authenticatedUser, pageable);
        } else {
            return repository.findDistinctByTitleContainingIgnoreCaseAndParticipantsContaining(title, authenticatedUser, pageable); 
        }
    }

    @Transactional
    public GroupTask editGroupTask(String id, GroupTaskCreateDTO data) {
        UserSS userSS = UserService.authenticated();
        GroupTask groupTask = getGroupTaskById(id);

        if (!groupTask.getAuthor().equals(userSS.getUsername()) && !groupTask.getEditors().contains(userSS.getUsername())) {
            throw new ForbiddenAccessException("Você não tem permissão para editar esta tarefa em grupo.");
        }

        groupTask.setTitle(data.title());
        groupTask.setDescription(data.description());

        // Atualiza a lista de editores
        groupTask.getEditors().clear();
        groupTask.getEditors().addAll(data.editors());

        groupTask.setStartDate(data.startDate());
        groupTask.setEndDate(data.endDate());

        // Atualiza a lista de usuários na tarefa em grupo
        groupTask.getParticipants().clear();
        groupTask.getParticipants().add(userService.findUserByUsername(groupTask.getAuthor())); // Re adiciona o autor
        for (String editorUsername : data.editors()) {
            if (!editorUsername.equals(groupTask.getAuthor())) { // Ignora o autor, se estiver na lista de editores
                User editor = userService.findUserByUsername(editorUsername);
                groupTask.getParticipants().add(editor);
            }
        }

        repository.save(groupTask);

        log.editGroupTask(groupTask.getId());
        return groupTask;
    }

    @Transactional
    public void deleteGroupTask(String id) {
        UserSS userSS = UserService.authenticated();
        GroupTask groupTask = getGroupTaskById(id);

        if (!groupTask.getAuthor().equals(userSS.getUsername())) {
            throw new ForbiddenAccessException("Somente o autor pode excluir esta tarefa em grupo.");
        }

        repository.delete(groupTask);
        log.deleteGroupTask(groupTask.getId());
    }
    
    @Transactional
    public GroupTask save(GroupTask groupTask) {
        return repository.save(groupTask);
    }
}