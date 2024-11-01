package com.leandroadal.vortasks.controllers.social;

import java.net.URI;
import org.hibernate.validator.constraints.UUID;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.leandroadal.vortasks.controllers.social.doc.GroupSubtaskDocSwagger;
import com.leandroadal.vortasks.entities.social.tasks.GroupSubtask;
import com.leandroadal.vortasks.entities.social.tasks.dto.grouptask.create.GroupSubtaskCreateDTO;
import com.leandroadal.vortasks.services.social.tasks.GroupSubtaskService;

import jakarta.validation.Valid;

@RestController
@RequestMapping("/social/groupTasks/{groupTaskId}/tasks")
public class GroupSubtaskController {

    @Autowired
    private GroupSubtaskService service;

    @PostMapping
    @GroupSubtaskDocSwagger.CreateGroupSubtaskSwagger
    public ResponseEntity<GroupSubtask> createIndividualTask(@PathVariable @UUID String groupTaskId,
            @Valid @RequestBody GroupSubtaskCreateDTO data) {
        GroupSubtask subTask = service.createSubTask(groupTaskId, data);
        URI uri = ServletUriComponentsBuilder.fromCurrentRequest().path("/{id}")
                .buildAndExpand(subTask.getId()).toUri();
        return ResponseEntity.created(uri).body(subTask);
    }

    @PutMapping("/{subTaskId}")
    @GroupSubtaskDocSwagger.EditGroupSubtaskSwagger
    public ResponseEntity<GroupSubtask> editIndividualTask(@PathVariable @UUID String groupTaskId,
            @PathVariable @UUID String subTaskId, @Valid @RequestBody GroupSubtaskCreateDTO data) {
        GroupSubtask subTask = service.editSubtask(groupTaskId, subTaskId, data);
        return ResponseEntity.ok(subTask);
    }

    @DeleteMapping("/{subTaskId}")
    @GroupSubtaskDocSwagger.DeleteGroupSubtaskSwagger
    public ResponseEntity<Void> deleteSubTask(@PathVariable @UUID String groupTaskId,
            @PathVariable @UUID String subTaskId) {
        service.deleteSubTask(groupTaskId, subTaskId);
        return ResponseEntity.noContent().build();
    }
}
