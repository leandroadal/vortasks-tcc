package com.leandroadal.vortasks.controllers.social.doc;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;
import com.leandroadal.vortasks.controllers.exceptions.StandardError;
import com.leandroadal.vortasks.controllers.exceptions.ValidationError;
import com.leandroadal.vortasks.entities.social.tasks.dto.grouptask.GroupTaskInviteDTO;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.ArraySchema;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;

@Target({ ElementType.METHOD })
@Retention(RetentionPolicy.RUNTIME)
public @interface GroupTaskInviteDocSwagger {

    @Target({ ElementType.METHOD })
    @Retention(RetentionPolicy.RUNTIME)
    @Operation(summary = "Criar convites para tarefa em grupo", description = "Cria convites para usuários participarem de uma tarefa em grupo")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Convites criados com sucesso", content = {
                    @Content(mediaType = "application/json", array = @ArraySchema(schema = @Schema(implementation = GroupTaskInviteDTO.class))) }),
            @ApiResponse(responseCode = "400", description = "Dados de convite inválidos",
                content = @Content(mediaType = "application/json", schema = @Schema(oneOf = {ValidationError.class, StandardError.class}))),
            @ApiResponse(responseCode = "403", description = "Acesso negado", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "404", description = "Tarefa em grupo não encontrada", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }) })
    @SecurityRequirement(name = "bearerAuth")
    @interface CreateInvitesSwagger {
    }

    @Target({ ElementType.METHOD })
    @Retention(RetentionPolicy.RUNTIME)
    @Operation(summary = "Listar convites do usuário", description = "Lista os convites para tarefas em grupo recebidos pelo usuário autenticado")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Convites listados com sucesso", content = {
                    @Content(mediaType = "application/json", array = @ArraySchema(schema = @Schema(implementation = GroupTaskInviteDTO.class))) }),
            @ApiResponse(responseCode = "403", description = "Acesso negado", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }) })
    @SecurityRequirement(name = "bearerAuth")
    @interface GetUserInvitesSwagger {
    }

    @Target({ ElementType.METHOD })
    @Retention(RetentionPolicy.RUNTIME)
    @Operation(summary = "Listar convites por tarefa em grupo", description = "Lista todos os convites para uma tarefa em grupo específica.")
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "Convites listados com sucesso", content = {
                @Content(mediaType = "application/json", array = @ArraySchema(schema = @Schema(implementation = GroupTaskInviteDTO.class))) }),
        @ApiResponse(responseCode = "404", description = "Tarefa não encontrada", content = {
                @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
        @ApiResponse(responseCode = "500", description = "Erro interno no servidor", content = {
                @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) })
    })
    @SecurityRequirement(name = "bearerAuth")
    @interface GetInvitesByGroupTaskSwagger {
    }

    @Target({ ElementType.METHOD })
    @Retention(RetentionPolicy.RUNTIME)
    @Operation(summary = "Aceitar convite para tarefa em grupo", description = "Aceita um convite para participar de uma tarefa em grupo")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Convite aceito com sucesso", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = GroupTaskInviteDTO.class)) }),
            @ApiResponse(responseCode = "403", description = "Acesso negado", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "404", description = "Convite não encontrado", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }) })
    @SecurityRequirement(name = "bearerAuth")
    @interface AcceptInviteSwagger {
    }

    @Target({ ElementType.METHOD })
    @Retention(RetentionPolicy.RUNTIME)
    @Operation(summary = "Rejeitar convite para tarefa em grupo", description = "Rejeita um convite para participar de uma tarefa em grupo")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Convite rejeitado com sucesso", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = GroupTaskInviteDTO.class)) }),
            @ApiResponse(responseCode = "403", description = "Acesso negado", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "404", description = "Convite não encontrado", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }) })
    @SecurityRequirement(name = "bearerAuth")
    @interface RejectInviteSwagger {
    }
}