package com.leandroadal.vortasks.controllers.auth.doc;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import org.springframework.web.bind.MethodArgumentNotValidException;

import com.leandroadal.vortasks.controllers.exceptions.StandardError;
import com.leandroadal.vortasks.entities.user.dto.LoginResponseDTO;
import com.leandroadal.vortasks.entities.user.dto.create.UserCreateResponse;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;

@Target({ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
public @interface AuthDocSwagger {

        @Target({ElementType.METHOD})
        @Retention(RetentionPolicy.RUNTIME)
        @Operation(summary = "Autenticação do usuário", description = "Autentica um usuário com username/email e senha")
        @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Token de autenticação gerado com sucesso", content = { @Content(mediaType = "application/json", 
            schema = @Schema(implementation = LoginResponseDTO.class)) }),
            @ApiResponse(responseCode = "401", description = "Credenciais inválidas",
                    content = {@Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class))}),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor",
                    content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)))
        })
        @interface LoginSwagger {
        }
        
        @Target({ElementType.METHOD})
        @Retention(RetentionPolicy.RUNTIME)
        @Operation(summary = "Desloga um usuário", description = "Torno o token de autenticação do usuário invalido")
        @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Logout realizado com sucesso"),
            @ApiResponse(responseCode = "403", description = "Token de autenticação inválido ou revogado",
                    content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class))),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor", 
                    content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)))
        })
        @SecurityRequirement(name = "bearerAuth")
        @interface LogoutSwagger {
        }
        
        @Target({ElementType.METHOD})
        @Retention(RetentionPolicy.RUNTIME)
        @Operation(summary = "Registra um novo usuário", description = "Registra um novo usuário com os dados fornecidos")
        @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "Usuário criado com sucesso", content = { @Content(mediaType = "application/json", 
            schema = @Schema(implementation = UserCreateResponse.class)) }),
            @ApiResponse(responseCode = "400", description = "Dados de registro inválidos",
                    content = @Content(mediaType = "application/json", schema = @Schema(oneOf = {StandardError.class, MethodArgumentNotValidException.class}))),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor", 
                    content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)))
        })
        @interface RegisterSwagger {
        }
        
        @Target({ElementType.METHOD})
        @Retention(RetentionPolicy.RUNTIME)
        @Operation(summary = "Criar um novo usuário com perfil de administrador", description = "Um administrador consegue cria um novo usuário com perfil de administrador")
        @ApiResponses(value = {
                @ApiResponse(responseCode = "201", description = "Usuário administrador criado com sucesso", content = { @Content(mediaType = "application/json", 
                schema = @Schema(implementation = UserCreateResponse.class)) }),
                @ApiResponse(responseCode = "400", description = "Dados de registro inválidos",
                        content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class))),
                @ApiResponse(responseCode = "403", description = "Acesso negado", 
                        content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class))),
                @ApiResponse(responseCode = "500", description = "Erro interno no servidor", 
                    content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)))
        })
        @SecurityRequirement(name = "bearerAuth")
        @interface CreateAdminSwagger {
        }

}
