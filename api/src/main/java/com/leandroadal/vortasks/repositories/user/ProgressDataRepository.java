package com.leandroadal.vortasks.repositories.user;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.leandroadal.vortasks.entities.user.ProgressData;

public interface ProgressDataRepository extends JpaRepository<ProgressData, String> {

    Optional<ProgressData> findByUserId(String userId);
}
