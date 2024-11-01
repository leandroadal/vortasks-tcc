package com.leandroadal.vortasks.services.backup.exceptions;

public class BackupCreationException extends RuntimeException {
    public BackupCreationException(String message, String userId) {
        super(message + userId);
    }

    public BackupCreationException(String message, Throwable cause) {
        super(message, cause);
    }
}
