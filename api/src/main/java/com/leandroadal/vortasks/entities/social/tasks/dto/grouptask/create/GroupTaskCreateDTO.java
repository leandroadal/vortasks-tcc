package com.leandroadal.vortasks.entities.social.tasks.dto.grouptask.create;

import java.time.Instant;
import java.util.List;
import com.leandroadal.vortasks.entities.social.tasks.GroupTask;
import com.fasterxml.jackson.annotation.JsonFormat;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;


public record GroupTaskCreateDTO(
    @NotBlank(message = "O título não pode estar em branco") String title,

    String description,

    @NotEmpty(message = "A lista de editores não pode estar vazia") List<String> editors,

    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd'T'HH:mm:ss'Z'", timezone = "UTC")
    Instant startDate, // Data de início

    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd'T'HH:mm:ss'Z'", timezone = "UTC")
    Instant endDate,   // Data de término

    boolean finish,

    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd'T'HH:mm:ss'Z'", timezone = "UTC")
    Instant dateFinish,
    
    List<GroupSubtaskCreateDTO> groupSubtasks
) {

    public GroupTask toGroupTask() {
        GroupTask task = new GroupTask();
        task.setTitle(this.title);
        task.setDescription(this.description);
        task.setEditors(this.editors);
        task.setStartDate(this.startDate);
        task.setEndDate(this.endDate);
        task.setFinish(finish);
        task.setDateFinish(dateFinish);
        // As subtarefas serão adicionadas pelo serviço
        return task;
    }

}
