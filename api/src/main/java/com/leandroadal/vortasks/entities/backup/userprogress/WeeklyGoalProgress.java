package com.leandroadal.vortasks.entities.backup.userprogress;

import com.leandroadal.vortasks.entities.backup.Backup;
import com.leandroadal.vortasks.entities.backup.userprogress.enums.TaskType;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@Entity
@NoArgsConstructor
public class WeeklyGoalProgress {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private String id;

    private Integer month;
    private Integer weekNumber; // Número da semana no mês

    private TaskType type; // PRODUCTIVITY ou WELL_BEING
    private Integer successes;
    private Integer failures;

    @ManyToOne
    @JoinColumn(name = "backup_id")
    private Backup backup;
}