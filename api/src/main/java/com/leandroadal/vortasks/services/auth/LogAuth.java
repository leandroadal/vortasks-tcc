package com.leandroadal.vortasks.services.auth;

import org.springframework.stereotype.Component;

import com.leandroadal.vortasks.security.UserSS;
import com.leandroadal.vortasks.services.user.UserService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class LogAuth {

    protected void register(String id) {
        log.info("O usuário com ID: '"+id+"' foi registrado com sucesso!");
    }
    
    protected void login(String id) {
        log.info("O usuário com ID: '"+id+"' autenticado com sucesso!");
    }

    protected void logout(String token) {
        UserSS userSS = UserService.authenticated();
        log.debug("Adicionando o token: {} a lista de tokens revogados",token);
        log.info("O usuário com ID: '"+userSS.getId()+"' deslogado com sucesso!");
    }

    protected void usernameAlreadyExists(String id) {
        log.info("O usuário com o Username: '"+id+"' já existe!");
    }

    protected void emailAlreadyExists(String email) {
        log.info("O usuário com o Email: '"+email+"' já existe!");
    }
}
