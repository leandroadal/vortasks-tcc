package com.leandroadal.vortasks.security;

import java.time.Instant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTCreationException;
import com.auth0.jwt.exceptions.JWTVerificationException;
import com.auth0.jwt.exceptions.TokenExpiredException;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class JWTService {

    @Value("${api.security.token.secret}")
    private String secret;

    @Value("${api.security.token.expiration}")
    private long expirationInMilliseconds;

    @Autowired
    private TokenCache tokenCache;

    public String generateToken(UserSS user) {
        try {
            Algorithm algorithm = Algorithm.HMAC256(secret);
            String token = JWT.create()
                    .withIssuer("vortasks")
                    .withSubject(user.getUsername())
                    .withExpiresAt(genExpirationDate())
                    .sign(algorithm);
            log.info("Token gerado com sucesso para o usuário: {}", user.getUsername());
            return token;

        } catch (JWTCreationException e) {
            log.error("Erro ao gerar o token: {}", e.getMessage(), e);
            throw new JWTException("Erro ao gerar o token", e);
        }
    }

    public String validateToken(String token) {
        if (tokenCache.isTokenRevoked(token)) {
            log.info("Adicionando o token: {} a lista de tokens revogados", token);
            throw new JWTException("Token revogado!");
        }

        try {
            Algorithm algorithm = Algorithm.HMAC256(secret);
            String username = JWT.require(algorithm)
                    .withIssuer("vortasks")
                    .build()
                    .verify(token)
                    .getSubject();
            log.debug("Token validado com sucesso para o usuário: {}", username);
            return username;

        } catch (TokenExpiredException e) {
            //log.error("Token expirado: {}", e.getMessage(), e);
            throw new JWTException(e.getMessage(), e);

        } catch (JWTVerificationException exception) {
            //log.error("Erro ao verificar o token: {}", exception.getMessage(), exception);
            throw new JWTException("Token Invalido!", exception);
        }
    }

    private Instant genExpirationDate() {
        return Instant.now().plusMillis(expirationInMilliseconds);
    }
}
