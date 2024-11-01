package com.leandroadal.vortasks.services.backup;

import org.springframework.stereotype.Service;

import com.leandroadal.vortasks.entities.user.User;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class LogBackupService {
    
    protected void logBackupCreationFailure(User user) {
        log.error("Erro ao criar o backup para o usuário '{}' com o username '{}'", user.getId(),
                user.getUsername());
    }

    protected void logBackupCreationSuccess(User user) {
        log.info("Backup criado com sucesso para o usuário '{}' com o username '{}'",
                user.getId(), user.getUsername());
    }

    protected void logBackupUpdateSuccess(String id) {
        log.info("Backup com o ID: '{}' atualizado com sucesso!", id);
    }

    protected void logBackupDeletionSuccess(String userId) {
        log.info("Backup excluído com sucesso para o usuário {}", userId);
    }

    public void logGetBackupByUserId(String userId) {
        log.error("Falha ao recuperar o backup do id: {}", userId);
    }
    
}
