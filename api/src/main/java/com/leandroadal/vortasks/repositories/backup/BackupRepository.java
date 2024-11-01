package com.leandroadal.vortasks.repositories.backup;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.leandroadal.vortasks.entities.backup.Backup;

public interface BackupRepository extends JpaRepository<Backup, String> {

    Optional<Backup> findByUserId(String userId);

}
