package com.leandroadal.vortasks.security;

import java.time.Instant;

public class RevokedToken {
    private final String token;
    private final Instant expiration;

    public RevokedToken(String token, Instant expiration) {
        this.token = token;
        this.expiration = expiration;
    }

    public String getToken() {
        return token;
    }

    public Instant getExpiration() {
        return expiration;
    }
}
