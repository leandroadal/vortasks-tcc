package com.leandroadal.vortasks.controllers.auth;

import java.net.URI;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.leandroadal.vortasks.controllers.auth.doc.AuthDocSwagger;
import com.leandroadal.vortasks.entities.user.User;
import com.leandroadal.vortasks.entities.user.dto.LoginDTO;
import com.leandroadal.vortasks.entities.user.dto.LoginResponseDTO;
import com.leandroadal.vortasks.entities.user.dto.create.UserCreateDTO;
import com.leandroadal.vortasks.entities.user.dto.create.UserCreateResponse;
import com.leandroadal.vortasks.services.auth.AuthService;
import com.leandroadal.vortasks.services.exception.InvalidCredentialsException;
import com.leandroadal.vortasks.services.exception.ValidateException;

import jakarta.validation.Valid;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;

@RestController
@RequestMapping(value = "/auth")
//@DefaultDocSwagger
public class AuthController {

    @Autowired
    private AuthService service;

    /**
     * Autentica um usuário.
     *
     * @param data Objeto com o username e senha do usuário.
     * @return O token de autenticação.
     * @throws InvalidCredentialsException
     */
    @AuthDocSwagger.LoginSwagger  // Responsável pela documentação do endpoint no swagger
    @PostMapping(value = "/login")   
    public ResponseEntity<LoginResponseDTO> login(@RequestBody @Valid LoginDTO data) { 
        String token = service.login(data.username(), data.password());
        return ResponseEntity.ok(new LoginResponseDTO(token));
    }

    /**
     * Desloga um usuário.
     *
     * @param token Token de autenticação.
     * @return Mensagem de sucesso.
     */
    @AuthDocSwagger.LogoutSwagger
    @PostMapping(value = "/logout")
    public ResponseEntity<String> logout(@RequestHeader("Authorization") String token) {
        service.logout(token);
        return ResponseEntity.ok("Logout realizado com sucesso!");
    }
    
    /**
     * Registra um novo usuário.
     *
     * @param userDTO Objeto com os dados do usuário.
     * @return Objeto com o ID do usuário criado.
     * @throws ValidateException
     */
    @AuthDocSwagger.RegisterSwagger
    @PostMapping("/register")
    public ResponseEntity<UserCreateResponse> register(@RequestBody @Valid UserCreateDTO userDTO) {
        User newUser = userDTO.toUser();
        newUser = service.register(newUser);

        //backupService.createBackup();

        URI uri = ServletUriComponentsBuilder.fromCurrentRequest()
                .replacePath("/shop/category/{id}")
                .buildAndExpand(newUser.getId())
                .toUri();
        return ResponseEntity.created(uri).body(new UserCreateResponse(newUser));
    }

    /**
     * Cria um novo usuário com perfil de administrador.
     *
     * @param userDTO Objeto com os dados do usuário.
     * @return Objeto com o ID do usuário criado.
     * @throws ValidateException
     */
    @AuthDocSwagger.CreateAdminSwagger
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    @PostMapping(value = "/admin")
    public ResponseEntity<UserCreateResponse> createAdmin(@RequestBody UserCreateDTO userDTO) {
        User newUser = userDTO.toUser();
        newUser = service.createAdmin(newUser);
        URI uri = ServletUriComponentsBuilder.fromCurrentRequest()
                .replacePath("/shop/category/{id}")
                .buildAndExpand(newUser.getId())
                .toUri();
        return ResponseEntity.created(uri).body(new UserCreateResponse(newUser));
    }

}
