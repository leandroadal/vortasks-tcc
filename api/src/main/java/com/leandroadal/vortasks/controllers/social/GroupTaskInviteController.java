package com.leandroadal.vortasks.controllers.social;

import java.util.List;
import org.hibernate.validator.constraints.UUID;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.leandroadal.vortasks.controllers.social.doc.GroupTaskInviteDocSwagger;
import com.leandroadal.vortasks.entities.social.tasks.GroupTaskInvite;
import com.leandroadal.vortasks.entities.social.tasks.dto.grouptask.GroupTaskInviteDTO;
import com.leandroadal.vortasks.entities.social.tasks.dto.grouptask.create.GroupTaskInvitesDTO;
import com.leandroadal.vortasks.services.social.tasks.GroupTaskInviteService;

import jakarta.validation.Valid;

@RestController
@RequestMapping("/social/groupTasks/invites")
public class GroupTaskInviteController {

    @Autowired
    private GroupTaskInviteService service;

    @PostMapping("/{groupTaskId}")
    @GroupTaskInviteDocSwagger.CreateInvitesSwagger
    public ResponseEntity<List<GroupTaskInviteDTO>> createInvites(@PathVariable @UUID String groupTaskId, @Valid @RequestBody GroupTaskInvitesDTO data) {
        List<GroupTaskInvite> invites = service.createInvites(groupTaskId, data.usernames());

        // Converte a lista de GroupTaskInvite para GroupTaskInviteDTO
        List<GroupTaskInviteDTO> inviteDTOs = invites.stream()
                                                    .map(GroupTaskInviteDTO::new)
                                                    .toList();
        return ResponseEntity.ok(inviteDTOs);
    }

    @GetMapping
    @GroupTaskInviteDocSwagger.GetUserInvitesSwagger
    public ResponseEntity<List<GroupTaskInviteDTO>> getUserInvites() {
        List<GroupTaskInvite> invites = service.getInvitesForUser();
        return ResponseEntity.ok(invites.stream()
                                .map(GroupTaskInviteDTO::new)
                                .toList());
    }

    @GetMapping("/task/{groupTaskId}")
    @GroupTaskInviteDocSwagger.GetInvitesByGroupTaskSwagger
    public ResponseEntity<List<GroupTaskInviteDTO>> getInvitesByGroupTask(@PathVariable @UUID String groupTaskId) {
        List<GroupTaskInvite> invites = service.getInvitesByGroupTask(groupTaskId);
        return ResponseEntity.ok(invites.stream()
                                .map(GroupTaskInviteDTO::new)
                                .toList());
    }

    @PutMapping("/{inviteId}/accept")
    @GroupTaskInviteDocSwagger.AcceptInviteSwagger
    public ResponseEntity<GroupTaskInviteDTO> acceptInvite(@PathVariable @UUID String inviteId) {
        GroupTaskInvite invite = service.acceptInvite(inviteId);
        return ResponseEntity.ok(new GroupTaskInviteDTO(invite));
    }

    @PutMapping("/{inviteId}/reject")
    @GroupTaskInviteDocSwagger.RejectInviteSwagger
    public ResponseEntity<GroupTaskInviteDTO> rejectInvite(@PathVariable @UUID String inviteId) {
        GroupTaskInvite invite = service.rejectInvite(inviteId);
        return ResponseEntity.ok(new GroupTaskInviteDTO(invite));
    }
}