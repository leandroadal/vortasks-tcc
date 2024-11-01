package com.leandroadal.vortasks.repositories.social;

import java.time.Instant;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.leandroadal.vortasks.entities.social.tasks.GroupTask;
import com.leandroadal.vortasks.entities.user.User;

public interface GroupTaskRepository extends JpaRepository<GroupTask, String> {

    List<GroupTask> findByAuthor(String author);

    @Query("SELECT gt FROM GroupTask gt WHERE :user MEMBER OF gt.participants")
    List<GroupTask> findAllGroupTasksByUser(@Param("user") User user);

    Page<GroupTask> findDistinctByTitleContainingIgnoreCaseAndParticipantsContaining(String title, User authenticatedUser,
            Pageable pageable);

    Page<GroupTask> findByTitleContainingIgnoreCaseAndEndDateBetweenAndParticipantsContaining(String title,
            Instant startOfDay,
            Instant endOfDay, User authenticatedUser, Pageable pageable);

        @Query("SELECT gt FROM GroupTask gt " +
        "JOIN FETCH gt.groupSubtasks sub " +
        "LEFT JOIN FETCH sub.skills " +
        "LEFT JOIN FETCH sub.participants " +
        "WHERE gt.id = :id")
        GroupTask findByIdFetchSubtasksSkillsParticipants(@Param("id") String id);
}
