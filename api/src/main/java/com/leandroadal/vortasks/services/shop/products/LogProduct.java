package com.leandroadal.vortasks.services.shop.products;

import org.springframework.stereotype.Component;
import com.leandroadal.vortasks.security.UserSS;
import com.leandroadal.vortasks.services.user.UserService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class LogProduct {

    public void logProductFind(Long id) {
        log.error("Produto com ID: '{}' não encontrado!", id);
    }

    public void logDeleteFailed(Long id) {
        log.error("Produto com ID: '{}' falhou ao deletar!", id);
    }

    protected void logAddProduct(Long id) {
        UserSS userSS = UserService.authenticated();
        log.info("Produto com ID: '{}' adicionado com sucesso pelo usuário: "+ userSS.getId(), id);
    }

    protected void logEditProduct(Long id) {
        UserSS userSS = UserService.authenticated();
        log.info("Produto com ID: '{}' editado com sucesso pelo usuário: "+ userSS.getId(), id);
    }

    protected void logPartialEditProduct(Long id) {
        UserSS userSS = UserService.authenticated();
        log.info("Atualização parcial do produto com ID: '{}' foi realizada com sucesso pelo usuário: "+ userSS.getId(), id);
    }

    protected void logDeleteProduct(Long id) {
        UserSS userSS = UserService.authenticated();
        log.info("Produto com ID: '{}' deletado com sucesso pelo usuário: "+ userSS.getId(), id);
    }

}
