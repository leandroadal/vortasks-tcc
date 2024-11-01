package com.leandroadal.vortasks.repositories.backup;

import org.springframework.data.jpa.repository.JpaRepository;

import com.leandroadal.vortasks.entities.backup.userprogress.Achievement;

public interface AchievementRepository extends JpaRepository<Achievement, String> {

}
