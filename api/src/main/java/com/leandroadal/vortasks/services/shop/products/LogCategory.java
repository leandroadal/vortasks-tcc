package com.leandroadal.vortasks.services.shop.products;

import org.springframework.stereotype.Component;
import com.leandroadal.vortasks.security.UserSS;
import com.leandroadal.vortasks.services.user.UserService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class LogCategory {

    protected void categoryNotFound(Integer id) {
        log.error("Categoria com ID: '{}' não encontrada!", id);
    }

    protected void logCategoryDeleteFailed(Integer id) {
        UserSS userSS = UserService.authenticated();
        log.error("O usuário '"+userSS.getId()+"' obteve Erro de DataIntegrityViolation ao tenta deletar o ID: {}", id);
    }

    protected void logAddCategory(Integer id) {
        UserSS userSS = UserService.authenticated();
        log.info("Categoria com ID: '{}' criada com sucesso pelo usuário: "+ userSS.getId(), id);
    }

    protected void logCategoryEdit(Integer id) {
        UserSS userSS = UserService.authenticated();
        log.info("Categoria com ID: '{}' foi editada com sucesso pelo usuário: "+ userSS.getId(), id);
    }

    protected void logPartialEditCategory(Integer id) {;
        UserSS userSS = UserService.authenticated();
        log.info("Atualização parcial da Categoria com ID: '{}' foi realizada com sucesso pelo usuário: "+ userSS.getId(), id);
    }

    protected void logCategoryDelete(Integer id) {
        UserSS userSS = UserService.authenticated();
        log.info("Categoria com ID: '{}' foi deletada com sucesso pelo usuário: "+ userSS.getId(), id);
    }

}
