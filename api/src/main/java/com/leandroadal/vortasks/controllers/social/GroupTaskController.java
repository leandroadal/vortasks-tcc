package com.leandroadal.vortasks.controllers.social;

import java.net.URI;
import java.time.Instant;
import java.util.List;
import java.util.stream.Collectors;

import org.hibernate.validator.constraints.UUID;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.leandroadal.vortasks.controllers.social.doc.GroupTaskDocSwagger;
import com.leandroadal.vortasks.entities.social.tasks.GroupTask;
import com.leandroadal.vortasks.entities.social.tasks.dto.grouptask.GroupTaskResponseDTO;
import com.leandroadal.vortasks.entities.social.tasks.dto.grouptask.create.GroupTaskCreateDTO;
import com.leandroadal.vortasks.services.social.tasks.GroupTaskService;

import jakarta.validation.Valid;

@RestController
@RequestMapping("/social/groupTasks")
public class GroupTaskController {

    @Autowired
    private GroupTaskService service;

    @PostMapping
    @GroupTaskDocSwagger.CreateGroupTaskSwagger
    public ResponseEntity<GroupTaskResponseDTO> createGroupTask(@Valid @RequestBody GroupTaskCreateDTO data) {
        GroupTask groupTask = service.createGroupTask(data);
        URI uri = ServletUriComponentsBuilder.fromCurrentRequest().path("/{id}")
                .buildAndExpand(groupTask.getId()).toUri();
        return ResponseEntity.created(uri).body(new GroupTaskResponseDTO(groupTask));
    }

    @GetMapping
    @GroupTaskDocSwagger.GetMyGroupTasksSwagger
    public ResponseEntity<List<GroupTaskResponseDTO>> getMyGroupTasks() {
        List<GroupTask> groupTasks = service.getGroupTasksByUser();
        List<GroupTaskResponseDTO> dtos = groupTasks.stream()
                .map(GroupTaskResponseDTO::new)
                .collect(Collectors.toList());
        return ResponseEntity.ok(dtos);
    }

    @GetMapping("/{id}")
    @GroupTaskDocSwagger.GetGroupTaskSwagger
    public ResponseEntity<GroupTaskResponseDTO> getGroupTask(@PathVariable @UUID String id) {
        GroupTask groupTask = service.getGroupTaskWithIndividualTasks(id);
        return ResponseEntity.ok(new GroupTaskResponseDTO(groupTask));
    }

    @GetMapping("/search")
    @GroupTaskDocSwagger.SearchGroupTasksSwagger
    public ResponseEntity<Page<GroupTaskResponseDTO>> searchGroupTasks(
        @RequestParam(value = "title", defaultValue = "") String title,
        @RequestParam(value = "endDate", required = false)  @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd'T'HH:mm:ss'Z'", timezone = "UTC") Instant endDate,
        @RequestParam(value = "page", defaultValue = "0") Integer page,
        @RequestParam(value = "linesPerPage", defaultValue = "10") Integer linesPerPage,
        @RequestParam(value = "orderBy", defaultValue = "createdAt") String orderBy,
        @RequestParam(value = "direction", defaultValue = "ASC") String direction) {

        PageRequest pageRequest = PageRequest.of(page, linesPerPage, Direction.valueOf(direction), orderBy);
        Page<GroupTask> list = service.searchGroupTasks(title, endDate, pageRequest);
        Page<GroupTaskResponseDTO> listDto = list.map(GroupTaskResponseDTO::new);
        return ResponseEntity.ok(listDto);
    }

    @PutMapping("/{id}")
    @GroupTaskDocSwagger.EditGroupTaskSwagger
    public ResponseEntity<GroupTaskResponseDTO> editGroupTask(@PathVariable @UUID String id,
            @Valid @RequestBody GroupTaskCreateDTO data) {
        GroupTask groupTask = service.editGroupTask(id, data);
        return ResponseEntity.ok(new GroupTaskResponseDTO(groupTask));
    }

    @DeleteMapping("/{id}")
    @GroupTaskDocSwagger.DeleteGroupTaskSwagger
    public ResponseEntity<Void> deleteGroupTask(@PathVariable @UUID String id) {
        service.deleteGroupTask(id);
        return ResponseEntity.noContent().build();
    }
}
