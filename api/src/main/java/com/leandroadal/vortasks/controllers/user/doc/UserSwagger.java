package com.leandroadal.vortasks.controllers.user.doc;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import com.leandroadal.vortasks.controllers.exceptions.StandardError;
import com.leandroadal.vortasks.entities.user.dto.UserResponseDTO;
import com.leandroadal.vortasks.services.exception.ObjectNotFoundException;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;

@Target({ ElementType.METHOD })
@Retention(RetentionPolicy.RUNTIME)
public @interface UserSwagger {

    @Target({ ElementType.METHOD })
    @Retention(RetentionPolicy.RUNTIME)
    @Operation(summary = "Buscar meu usuário", description = "Retorna os dados do usuário autenticado.") // Descrição adicionada
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Usuário encontrado com sucesso", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = UserResponseDTO.class)) }),
            @ApiResponse(responseCode = "404", description = "Usuário não encontrado", content = { // adicionado content
                    @Content(mediaType = "application/json", schema = @Schema(implementation = ObjectNotFoundException.class)) }), // Tipo de exceção mais específico
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor", content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class))) })
    @SecurityRequirement(name = "bearerAuth")
    @interface GetMyUserSwagger {
    }

    @Target({ ElementType.METHOD })
    @Retention(RetentionPolicy.RUNTIME)
    @Operation(summary = "Obter nome de usuário por ID", description = "Retorna o nome de usuário de um usuário específico com base em seu ID.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Nome de usuário encontrado com sucesso", content = {
                    @Content(mediaType = "text/plain", schema = @Schema(implementation = String.class)) }),
            @ApiResponse(responseCode = "404", description = "Usuário não encontrado", content = { // adicionado content
                    @Content(mediaType = "application/json", schema = @Schema(implementation = ObjectNotFoundException.class)) }), // Tipo de exceção mais específico
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor", content = { // adicionado content
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }) })
    @SecurityRequirement(name = "bearerAuth")
    @interface GetUsernameByIdSwagger {
    }

}