package com.leandroadal.vortasks.controllers.social.doc;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import org.springframework.web.bind.MethodArgumentNotValidException;

import com.leandroadal.vortasks.controllers.exceptions.StandardError;
import com.leandroadal.vortasks.controllers.exceptions.ValidationError;
import com.leandroadal.vortasks.entities.social.tasks.GroupSubtask;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;

@Target({ ElementType.METHOD })
@Retention(RetentionPolicy.RUNTIME)
public @interface GroupSubtaskDocSwagger {

    @Target({ ElementType.METHOD })
    @Retention(RetentionPolicy.RUNTIME)
    @Operation(summary = "Criar sub-tarefa de grupo", description = "Cria uma nova sub-tarefa para uma tarefa em grupo.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "Sub-tarefa criada com sucesso", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = GroupSubtask.class)) }),
            @ApiResponse(responseCode = "400", description = "Dados de sub-tarefa inválidos", content = {
                    @Content(mediaType = "application/json", schema = @Schema(oneOf = {StandardError.class, MethodArgumentNotValidException.class})) }),
            @ApiResponse(responseCode = "403", description = "Acesso negado. Somente o autor e os editores podem criar sub-tarefas.", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "404", description = "Tarefa em grupo não encontrada", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }) })
    @SecurityRequirement(name = "bearerAuth")
    @interface CreateGroupSubtaskSwagger {
    }

    @Target({ ElementType.METHOD })
    @Retention(RetentionPolicy.RUNTIME)
    @Operation(summary = "Editar sub-tarefa de grupo", description = "Edita uma sub-tarefa existente de uma tarefa em grupo.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Sub-tarefa editada com sucesso", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = GroupSubtask.class)) }),
            @ApiResponse(responseCode = "400", description = "Dados de sub-tarefa inválidos",
                content = @Content(mediaType = "application/json", schema = @Schema(oneOf = {ValidationError.class, StandardError.class}))),
            @ApiResponse(responseCode = "403", description = "Acesso negado. Somente o autor e os editores podem editar sub-tarefas.", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "404", description = "Tarefa em grupo ou sub-tarefa não encontrada", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }) })
    @SecurityRequirement(name = "bearerAuth")
    @interface EditGroupSubtaskSwagger {
    }

    @Target({ ElementType.METHOD })
    @Retention(RetentionPolicy.RUNTIME)
    @Operation(summary = "Excluir sub-tarefa de grupo", description = "Exclui uma sub-tarefa de uma tarefa em grupo.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "204", description = "Sub-tarefa excluída com sucesso"),
            @ApiResponse(responseCode = "403", description = "Acesso negado. Somente o autor e os editores podem excluir sub-tarefas.", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "404", description = "Tarefa em grupo ou sub-tarefa não encontrada", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }) })
    @SecurityRequirement(name = "bearerAuth")
    @interface DeleteGroupSubtaskSwagger {
    }
}