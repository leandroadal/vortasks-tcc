package com.leandroadal.vortasks.services.social.friendship.exceptions;

public class FriendException extends RuntimeException {

    public FriendException(String message) {
        super(message);
    }

    public FriendException(String message, Throwable cause) {
        super(message, cause);
    }
}
