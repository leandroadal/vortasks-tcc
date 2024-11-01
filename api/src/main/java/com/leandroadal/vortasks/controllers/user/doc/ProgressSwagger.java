package com.leandroadal.vortasks.controllers.user.doc;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import com.leandroadal.vortasks.controllers.exceptions.StandardError;
import com.leandroadal.vortasks.controllers.exceptions.ValidationError;
import com.leandroadal.vortasks.entities.user.dto.ProgressDataResponseDTO;
import com.leandroadal.vortasks.services.backup.exceptions.ObjectNotModifiedException;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;

@Target({ ElementType.METHOD })
@Retention(RetentionPolicy.RUNTIME)
public @interface ProgressSwagger {

    @Target({ ElementType.METHOD })
    @Retention(RetentionPolicy.RUNTIME)
    @Operation(summary = "Buscar dados de progresso", description = "Busca os dados de progresso do usuário")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Dados de progresso encontrados com sucesso", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = ProgressDataResponseDTO.class)) }),
            @ApiResponse(responseCode = "403", description = "Acesso negado", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "404", description = "Dados de progresso não encontrados", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor", content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class))) })
    @SecurityRequirement(name = "bearerAuth")
    @interface GetProgressSwagger {
    }

    @Target({ ElementType.METHOD })
    @Retention(RetentionPolicy.RUNTIME)
    @Operation(summary = "Últimos dados de progresso", description = "Retorna os dados se forem mais recentes que os dados locais do usuário")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Dados de progresso encontrados com sucesso", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = ProgressDataResponseDTO.class)) }),
            @ApiResponse(responseCode = "304", description = "Progresso não modificado", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = ObjectNotModifiedException.class)) }),
            @ApiResponse(responseCode = "403", description = "Acesso negado", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "404", description = "Dados de progresso não encontrados", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor", content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class))) })

    @SecurityRequirement(name = "bearerAuth")
    @interface GetLatestProgressSwagger {
    }

    @Target({ ElementType.METHOD })
    @Retention(RetentionPolicy.RUNTIME)
    @Operation(summary = "Atualizar dados de progresso", description = "Atualiza os dados de progresso do usuário")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Dados de progresso atualizados com sucesso", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = ProgressDataResponseDTO.class)) }),
            @ApiResponse(responseCode = "400", description = "Dados de progresso inválidos",
                content = @Content(mediaType = "application/json", schema = @Schema(oneOf = {ValidationError.class, StandardError.class}))),
            @ApiResponse(responseCode = "403", description = "Acesso negado", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "404", description = "Dados de progresso não encontrados", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor", content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class))) })
    @SecurityRequirement(name = "bearerAuth")
    @interface UpdateProgressSwagger {
    }

    @Target({ ElementType.METHOD })
    @Retention(RetentionPolicy.RUNTIME)
    @Operation(summary = "Atualizar parcialmente dados de progresso", description = "Atualiza parcialmente os dados de progresso do usuário")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Dados de progresso atualizados com sucesso", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = ProgressDataResponseDTO.class)) }),
            @ApiResponse(responseCode = "400", description = "Dados de progresso inválidos",
                content = @Content(mediaType = "application/json", schema = @Schema(oneOf = {ValidationError.class, StandardError.class}))),
            @ApiResponse(responseCode = "403", description = "Acesso negado", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "404", description = "Dados de progresso não encontrados", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor", content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class))) })
    @SecurityRequirement(name = "bearerAuth")
    @interface UpdatePartialProgressSwagger {
    }

    @Target({ ElementType.METHOD })
    @Retention(RetentionPolicy.RUNTIME)
    @Operation(summary = "Excluir dados de progresso", description = "Exclui os dados de progresso do usuário")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "204", description = "Dados de progresso excluídos com sucesso"),
            @ApiResponse(responseCode = "403", description = "Acesso negado", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor", content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class))) })
    @SecurityRequirement(name = "bearerAuth")
    @interface DeleteProgressSwagger {
    }

}
