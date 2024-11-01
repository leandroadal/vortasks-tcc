package com.leandroadal.vortasks.services.user;

import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class LogUser {

    protected void userNotFound(String id) {
        log.error("Usuário com ID: {} não foi encontrado!", id);
    }

    protected void userByUsername(String username) {
        log.error("Usuário com o Username: {} não foi encontrado!", username);
    }

    protected void userByEmail(String email) {
        log.error("Usuário com E-mail: {} não foi encontrado!", email);;
    }

    protected void userByUsernameOrEmail(String username) {
        log.error("Usuário com o Username ou E-mail: {} não foi encontrado!", username);
    }

}
