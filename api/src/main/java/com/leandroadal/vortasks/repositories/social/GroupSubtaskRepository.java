package com.leandroadal.vortasks.repositories.social;

import org.springframework.data.jpa.repository.JpaRepository;

import com.leandroadal.vortasks.entities.social.tasks.GroupSubtask;

public interface GroupSubtaskRepository extends JpaRepository<GroupSubtask, String> {
}