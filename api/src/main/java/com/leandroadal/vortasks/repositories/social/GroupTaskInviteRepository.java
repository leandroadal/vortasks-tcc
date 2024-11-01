package com.leandroadal.vortasks.repositories.social;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.leandroadal.vortasks.entities.social.tasks.GroupTaskInvite;

public interface GroupTaskInviteRepository extends JpaRepository<GroupTaskInvite, String> {

    List<GroupTaskInvite> findByUserId(String userId);

    List<GroupTaskInvite> findByGroupTaskId(String groupTaskId);
}