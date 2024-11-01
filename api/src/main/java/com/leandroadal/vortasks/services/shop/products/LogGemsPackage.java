package com.leandroadal.vortasks.services.shop.products;

import org.springframework.stereotype.Component;
import com.leandroadal.vortasks.security.UserSS;
import com.leandroadal.vortasks.services.user.UserService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class LogGemsPackage {

    protected void logGemsPackageNotFind(Long id) {
        log.error("Pacote de gemas com ID: '{}' não encontrado!", id);
    }
    
    protected void logGemsPackageCreation(Long id) {
        UserSS userSS = UserService.authenticated();
        log.info("Pacote de gemas com ID: '{}' criado com sucesso pelo usuário: "+ userSS.getId(), id);
    }

    protected void logGemsPackageEdit(Long id) {
        UserSS userSS = UserService.authenticated();
        log.info("Pacote de gemas com ID: '{}' foi editado com sucesso pelo usuário: "+ userSS.getId(), id);
    }

    protected void logGemsPackagePartialEdit(Long id) {
        UserSS userSS = UserService.authenticated();
        log.info("Atualização parcial do pacote de gemas com ID: '{}' foi realizada com sucesso pelo usuário: "+ userSS.getId(), id);
    }

    protected void logGemsPackageDelete(Long id) {
        UserSS userSS = UserService.authenticated();
        log.info("Pacote de gemas com ID: '{}' foi deletado com sucesso pelo usuário: "+ userSS.getId(), id);
    }

}
