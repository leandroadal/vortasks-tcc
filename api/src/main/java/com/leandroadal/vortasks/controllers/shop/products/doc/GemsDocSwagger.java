package com.leandroadal.vortasks.controllers.shop.products.doc;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;
import com.leandroadal.vortasks.controllers.exceptions.StandardError;
import com.leandroadal.vortasks.controllers.exceptions.ValidationError;
import com.leandroadal.vortasks.entities.shop.dto.GemsPackResponseDTO;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.ArraySchema;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;

@Target({ ElementType.METHOD })
@Retention(RetentionPolicy.RUNTIME)
public @interface GemsDocSwagger {

    @Target({ ElementType.METHOD })
    @Retention(RetentionPolicy.RUNTIME)
    @Operation(summary = "Listar pacotes de gemas por página", description = "Lista pacotes de gemas por página")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Pacotes de gemas listados com sucesso", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = GemsPackResponseDTO.class)) }),
            @ApiResponse(responseCode = "400", description = "Erro de validação",
                    content = @Content(mediaType = "application/json", schema = @Schema(oneOf = {StandardError.class, ValidationError.class}))),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor", content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class))) })
    @interface FindPageGemsPackageSwagger {
    }

    @Target({ ElementType.METHOD })
    @Retention(RetentionPolicy.RUNTIME)
    @Operation(summary = "Buscar pacote de gemas por ID", description = "Busca um pacote de gemas pelo seu ID")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Pacote de gemas encontrado com sucesso", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = GemsPackResponseDTO.class)) }),
            @ApiResponse(responseCode = "404", description = "Pacote de gemas não encontrado", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor", content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class))) })
    @interface GetGemsPackageSwagger {
    }

    @Target({ ElementType.METHOD })
    @Retention(RetentionPolicy.RUNTIME)
    @Operation(summary = "Criar pacote de gemas (ADMIN)", description = "Cria um novo pacote de gemas")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "Pacote de gemas criado com sucesso"),
            @ApiResponse(responseCode = "400", description = "Dados de pacote de gemas inválidos", content = {
                    @Content(mediaType = "application/json", schema = @Schema(oneOf = {StandardError.class, ValidationError.class})) }),
            @ApiResponse(responseCode = "403", description = "Acesso negado", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor", content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class))) })
    @SecurityRequirement(name = "bearerAuth")
    @interface CreateGemsPackageSwagger {
    }

    @Target({ ElementType.METHOD })
    @Retention(RetentionPolicy.RUNTIME)
    @Operation(summary = "Listar todos os pacotes de gemas (ADMIN)", description = "Lista todos os pacotes de gemas disponíveis")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Pacotes de gemas listados com sucesso", content = {
                    @Content(mediaType = "application/json", array = @ArraySchema(schema = @Schema(implementation = GemsPackResponseDTO.class))) }),
            @ApiResponse(responseCode = "403", description = "Acesso negado", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor", content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class))) })
    @SecurityRequirement(name = "bearerAuth")
    @interface GetAllGemsPackageSwagger {
    }

    @Target({ ElementType.METHOD })
    @Retention(RetentionPolicy.RUNTIME)
    @Operation(summary = "Editar pacote de gemas (ADMIN)", description = "Edita um pacote de gemas existente")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Pacote de gemas editado com sucesso", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = GemsPackResponseDTO.class)) }),
            @ApiResponse(responseCode = "400", description = "Dados de pacote de gemas inválidos", content = {
                    @Content(mediaType = "application/json", schema = @Schema(oneOf = {StandardError.class, ValidationError.class})) }),
            @ApiResponse(responseCode = "403", description = "Acesso negado", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "404", description = "Pacote de gemas não encontrado", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor", content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class))) })
    @SecurityRequirement(name = "bearerAuth")
    @interface EditGemsPackageSwagger {
    }

    @Target({ ElementType.METHOD })
    @Retention(RetentionPolicy.RUNTIME)
    @Operation(summary = "Editar parcialmente pacote de gemas (ADMIN)", description = "Edita parcialmente um pacote de gemas existente")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Pacote de gemas editado com sucesso", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = GemsPackResponseDTO.class)) }),
            @ApiResponse(responseCode = "403", description = "Acesso negado", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "404", description = "Pacote de gemas não encontrado", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor", content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class))) })
    @SecurityRequirement(name = "bearerAuth")
    @interface PartialEditGemsPackageSwagger {
    }


    @Target({ ElementType.METHOD })
    @Retention(RetentionPolicy.RUNTIME)
    @Operation(summary = "Excluir pacote de gemas (ADMIN)", description = "Exclui um pacote de gemas existente")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "204", description = "Pacote de gemas excluído com sucesso"),
            @ApiResponse(responseCode = "403", description = "Acesso negado", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "404", description = "Pacote de gemas não encontrado", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor", content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class))) })
    @SecurityRequirement(name = "bearerAuth")
    @interface DeleteGemsPackageSwagger {
    }

}
