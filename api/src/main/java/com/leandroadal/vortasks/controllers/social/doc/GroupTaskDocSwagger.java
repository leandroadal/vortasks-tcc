package com.leandroadal.vortasks.controllers.social.doc;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;
import com.leandroadal.vortasks.controllers.exceptions.StandardError;
import com.leandroadal.vortasks.controllers.exceptions.ValidationError;
import com.leandroadal.vortasks.entities.social.tasks.dto.grouptask.GroupTaskResponseDTO;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.ArraySchema;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;

@Target({ ElementType.METHOD })
@Retention(RetentionPolicy.RUNTIME)
public @interface GroupTaskDocSwagger {

    @Target({ ElementType.METHOD })
    @Retention(RetentionPolicy.RUNTIME)
    @Operation(summary = "Buscar tarefa em grupo por ID", description = "Busca uma tarefa em grupo pelo seu ID")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Tarefa em grupo encontrada com sucesso", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = GroupTaskResponseDTO.class)) }),
            @ApiResponse(responseCode = "403", description = "Acesso negado", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "404", description = "Tarefa em grupo não encontrada", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor", content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class))) })
    @SecurityRequirement(name = "bearerAuth")
    @interface GetGroupTaskSwagger {
    }

    @Target({ ElementType.METHOD })
    @Retention(RetentionPolicy.RUNTIME)
    @Operation(summary = "Buscar tarefas em grupo", description = "Retorna uma lista paginada de tarefas em grupo que correspondem aos critérios de pesquisa.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Tarefas em grupo encontradas com sucesso.", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = GroupTaskResponseDTO.class)) }), 
            @ApiResponse(responseCode = "401", description = "Não autorizado.", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor.", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }) })
    @SecurityRequirement(name = "bearerAuth")
    @interface SearchGroupTasksSwagger {
    }


    @Target({ ElementType.METHOD })
    @Retention(RetentionPolicy.RUNTIME)
    @Operation(summary = "Criar tarefa em grupo", description = "Cria uma nova tarefa em grupo")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "Tarefa em grupo criada com sucesso", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = GroupTaskResponseDTO.class)) }),
            @ApiResponse(responseCode = "400", description = "Dados de tarefa em grupo inválidos",
                content = @Content(mediaType = "application/json", schema = @Schema(oneOf = {ValidationError.class, StandardError.class}))),
            @ApiResponse(responseCode = "403", description = "Acesso negado", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor", content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class))) })
    @SecurityRequirement(name = "bearerAuth")
    @interface CreateGroupTaskSwagger {
    }

    @Target({ ElementType.METHOD })
    @Retention(RetentionPolicy.RUNTIME)
    @Operation(summary = "Obter tarefas em grupo do usuário", description = "Retorna uma lista de todas as tarefas em grupo das quais o usuário autenticado participa.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Tarefas em grupo encontradas com sucesso.", content = {
                    @Content(mediaType = "application/json", array = @ArraySchema(schema = @Schema(implementation = GroupTaskResponseDTO.class))) }),
            @ApiResponse(responseCode = "401", description = "Não autorizado.", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "500", description = "Erro interno do servidor.", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }) })
    @SecurityRequirement(name = "bearerAuth")
    @interface GetMyGroupTasksSwagger {
    }

    @Target({ ElementType.METHOD })
    @Retention(RetentionPolicy.RUNTIME)
    @Operation(summary = "Editar tarefa em grupo", description = "Edita uma tarefa em grupo existente")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Tarefa em grupo editada com sucesso", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = GroupTaskResponseDTO.class)) }),
            @ApiResponse(responseCode = "400", description = "Dados de tarefa em grupo inválidos",
                content = @Content(mediaType = "application/json", schema = @Schema(oneOf = {ValidationError.class, StandardError.class}))),
            @ApiResponse(responseCode = "403", description = "Acesso negado", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "404", description = "Tarefa em grupo não encontrada", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor", content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class))) })
    @SecurityRequirement(name = "bearerAuth")
    @interface EditGroupTaskSwagger {
    }

    @Target({ ElementType.METHOD })
    @Retention(RetentionPolicy.RUNTIME)
    @Operation(summary = "Excluir tarefa em grupo", description = "Exclui uma tarefa em grupo existente")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "204", description = "Tarefa em grupo excluída com sucesso"),
            @ApiResponse(responseCode = "403", description = "Acesso negado", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "404", description = "Tarefa em grupo não encontrada", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor", content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class))) })
    @SecurityRequirement(name = "bearerAuth")
    @interface DeleteGroupTaskSwagger {
    }
}