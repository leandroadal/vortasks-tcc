package com.leandroadal.vortasks.services.backup.exceptions;

public class ObjectNotModifiedException extends RuntimeException {
    public ObjectNotModifiedException(String message, String userId) {
        super(message + ": " + userId);
    }

    public ObjectNotModifiedException(String message, Throwable cause) {
        super(message, cause);
    }
}
