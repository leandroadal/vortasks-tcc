package com.leandroadal.vortasks.security;

import java.time.Instant;
import java.util.HashSet;
import java.util.Set;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class TokenCache {
    private final Set<RevokedToken> revokedTokens = new HashSet<>();
    
    @Value("${api.security.token.expiration}")
    private long expirationInMilliseconds;

    public void revokeToken(String token) {
        revokedTokens.add(new RevokedToken(token, Instant.now().plusMillis(expirationInMilliseconds)));
    }

    public boolean isTokenRevoked(String token) {
        cleanExpiredTokens(); // Limpa os tokens expirados antes de verificar
        return revokedTokens.stream().anyMatch(rt -> rt.getToken().equals(token));
    }

    private void cleanExpiredTokens() {
        revokedTokens.removeIf(rt -> rt.getExpiration().isBefore(Instant.now()));
    }
}
