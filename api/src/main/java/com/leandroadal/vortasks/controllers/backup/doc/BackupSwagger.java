package com.leandroadal.vortasks.controllers.backup.doc;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import com.leandroadal.vortasks.controllers.exceptions.StandardError;
import com.leandroadal.vortasks.controllers.exceptions.ValidationError;
import com.leandroadal.vortasks.entities.backup.dto.BackupResponseDTO;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;

@Target({ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
public @interface BackupSwagger {

    @Target({ElementType.METHOD})
    @Retention(RetentionPolicy.RUNTIME)
    @Operation(summary = "Recuperar backup", description = "Recupera o último backup do usuário")
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "Backup retornado com sucesso", content = { @Content(mediaType = "application/json", 
        schema = @Schema(implementation = BackupResponseDTO.class)) }),
        @ApiResponse(responseCode = "404", description = "Backup não encontrado",
                content = {@Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class))}),
        @ApiResponse(responseCode = "500", description = "Erro interno no servidor",
                content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)))
    })
    @SecurityRequirement(name = "bearerAuth")
    @interface GetBackupSwagger {
    }

    @Target({ElementType.METHOD})
    @Retention(RetentionPolicy.RUNTIME)
    @Operation(summary = "Criar backup do usuário", description = "Cria um novo backup para o usuário")
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "Backup criado com sucesso", content = { @Content(mediaType = "application/json", 
        schema = @Schema(implementation = BackupResponseDTO.class)) }),
        @ApiResponse(responseCode = "400", description = "Erro de validação",
                content = @Content(mediaType = "application/json", schema = @Schema(oneOf = {ValidationError.class, StandardError.class}))),
        @ApiResponse(responseCode = "500", description = "Erro interno no servidor",
                content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)))
    })
    @SecurityRequirement(name = "bearerAuth")
    @interface CreateBackupSwagger {
    }    

    @Target({ElementType.METHOD})
    @Retention(RetentionPolicy.RUNTIME)
    @Operation(summary = "Atualizar backup do usuário", description = "Atualiza o backup do usuário com os dados fornecidos")
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "Backup atualizado com sucesso", content = { @Content(mediaType = "application/json", 
        schema = @Schema(implementation = BackupResponseDTO.class)) }),
        @ApiResponse(responseCode = "404", description = "Backup não encontrado",
                content = {@Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class))}),
        @ApiResponse(responseCode = "500", description = "Erro interno no servidor",
                content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)))
    })
    @SecurityRequirement(name = "bearerAuth")
    @interface UpdateBackupSwagger {
    }

    @Target({ElementType.METHOD})
    @Retention(RetentionPolicy.RUNTIME)
    @Operation(summary = "Excluir backup do usuário", description = "Exclui o backup do usuário")
    @ApiResponses(value = {
        @ApiResponse(responseCode = "204", description = "Backup excluído com sucesso"),
        @ApiResponse(responseCode = "404", description = "Backup não encontrado",
                content = {@Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class))}),
        @ApiResponse(responseCode = "500", description = "Erro interno no servidor",
                content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)))
    })
    @SecurityRequirement(name = "bearerAuth")
    @interface DeleteBackupSwagger {
    }

}
