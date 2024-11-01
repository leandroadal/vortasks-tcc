package com.leandroadal.vortasks.services.social.tasks;

import java.time.Instant;
import java.util.List;
import java.util.Optional;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.leandroadal.vortasks.entities.social.tasks.GroupTask;
import com.leandroadal.vortasks.entities.social.tasks.GroupTaskInvite;
import com.leandroadal.vortasks.entities.social.tasks.enums.InviteStatus;
import com.leandroadal.vortasks.entities.user.User;
import com.leandroadal.vortasks.repositories.social.GroupTaskInviteRepository;
import com.leandroadal.vortasks.repositories.social.GroupTaskRepository;
import com.leandroadal.vortasks.security.UserSS;
import com.leandroadal.vortasks.services.exception.ForbiddenAccessException;
import com.leandroadal.vortasks.services.exception.ObjectNotFoundException;
import com.leandroadal.vortasks.services.user.UserService;

@Service
public class GroupTaskInviteService {

    @Autowired
    private GroupTaskRepository groupTaskRepository;

    @Autowired
    private GroupTaskInviteRepository inviteRepository;

    @Autowired
    private UserService userService;

    @Autowired
    private LogSocialTasks log;

    @Transactional
    public List<GroupTaskInvite> createInvites(String groupTaskId, Set<String> usernames) {
        UserSS userSS = UserService.authenticated();
        GroupTask groupTask = getGroupTaskById(groupTaskId);

        if (!groupTask.getAuthor().equals(userSS.getUsername())) {
            throw new ForbiddenAccessException("Somente o autor da tarefa pode enviar convites");
        }

        return usernames.stream().map(username -> {
            User user = userService.findUserByUsername(username);
            if (user.getId().equals(userSS.getId())) {
                return null; // Pula o próprio usuário
            }
            return createInvite(groupTask, user);
        }).filter(Optional::isPresent).map(Optional::get).toList();
    }

    private Optional<GroupTaskInvite> createInvite(GroupTask groupTask, User user) {
        if (groupTask.getParticipants().contains(user)) {
            return Optional.empty(); // Usuário já está na tarefa
        }

        GroupTaskInvite invite = new GroupTaskInvite();
        invite.setGroupTask(groupTask);
        invite.setUser(user);
        invite.setStatus(InviteStatus.PENDING);
        invite.setCreatedAt(Instant.now());
        inviteRepository.save(invite);

        log.createGroupTaskInvite(invite.getId());
        return Optional.of(invite);
    }

    public List<GroupTaskInvite> getInvitesForUser() {
        UserSS userSS = UserService.authenticated();
        return inviteRepository.findByUserId(userSS.getId());
    }

     public List<GroupTaskInvite> getInvitesByGroupTask(String groupTaskId) {
        List<GroupTaskInvite> invites = inviteRepository.findByGroupTaskId(groupTaskId);
        return invites;
    }

    @Transactional
    public GroupTaskInvite acceptInvite(String inviteId) {
        UserSS userSS = UserService.authenticated();
        GroupTaskInvite invite = getInviteById(inviteId);

        if (!invite.getUser().getId().equals(userSS.getId())) {
            throw new ForbiddenAccessException("Você não tem permissão para aceitar este convite");
        }

        invite.setStatus(InviteStatus.ACCEPTED);
        inviteRepository.save(invite);

        GroupTask groupTask = invite.getGroupTask();
        groupTask.getParticipants().add(invite.getUser());
        groupTaskRepository.save(groupTask);

        log.acceptGroupTaskInvite(invite.getId());
        return invite;
    }

    @Transactional
    public GroupTaskInvite rejectInvite(String inviteId) {
        UserSS userSS = UserService.authenticated();
        GroupTaskInvite invite = getInviteById(inviteId);

        if (!invite.getUser().getId().equals(userSS.getId())) {
            throw new ForbiddenAccessException("Você não tem permissão para rejeitar este convite");
        }

        invite.setStatus(InviteStatus.REJECTED);
        inviteRepository.save(invite);

        log.rejectGroupTaskInvite(invite.getId());
        return invite;
    }

    private GroupTask getGroupTaskById(String id) {
        try {
            return groupTaskRepository.findById(id).orElseThrow(() -> new ObjectNotFoundException(id));
        } catch (Exception e) {
            log.notFoundGroupTaskById(id);
            throw e;
        }
    }

    private GroupTaskInvite getInviteById(String inviteId) {
        try {
            return inviteRepository.findById(inviteId).orElseThrow(() -> new ObjectNotFoundException(inviteId));
        } catch (Exception e) {
            log.notFoundGroupTaskInviteById(inviteId);
            throw e;
        }
    }
}