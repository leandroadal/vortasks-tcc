package com.leandroadal.vortasks.security;

public class JWTException extends RuntimeException {
    
    public JWTException(String message, Throwable cause) {
        super(message, cause);
    }
    public JWTException(String message) {
        super(message);
    }
}
