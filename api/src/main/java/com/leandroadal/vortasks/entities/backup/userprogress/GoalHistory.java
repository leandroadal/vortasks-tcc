package com.leandroadal.vortasks.entities.backup.userprogress;

import java.time.Instant;

import com.leandroadal.vortasks.entities.backup.Backup;
import com.leandroadal.vortasks.entities.backup.userprogress.enums.GoalType;
import com.leandroadal.vortasks.entities.backup.userprogress.enums.TaskType;

import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
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
public class GoalHistory {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private String id;

    private Instant date;
    private Integer weekNumber;

    @Enumerated(EnumType.STRING)
    private TaskType type;

    @Enumerated(EnumType.STRING)
    private GoalType goalType;

    private Integer successes;
    private Integer failures;

    @ManyToOne
    @JoinColumn(name = "backup_id")
    private Backup backup;
}
