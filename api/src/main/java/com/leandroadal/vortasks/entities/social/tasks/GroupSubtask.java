package com.leandroadal.vortasks.entities.social.tasks;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.leandroadal.vortasks.entities.backup.userprogress.AbstractTask;
import com.leandroadal.vortasks.entities.user.User;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.ManyToOne;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@Entity
@NoArgsConstructor
@AllArgsConstructor
public class GroupSubtask extends AbstractTask {

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "group_task_id")
    private GroupTask groupTask;

    @ManyToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinTable(name = "group_subtask_users", 
               joinColumns = @JoinColumn(name = "group_subtask_id"),
               inverseJoinColumns = @JoinColumn(name = "user_id"))
    private List<User> participants = new ArrayList<>();

    private Set<String> skills = new HashSet<>();
}
