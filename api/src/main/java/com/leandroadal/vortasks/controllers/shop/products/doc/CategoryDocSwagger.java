package com.leandroadal.vortasks.controllers.shop.products.doc;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import com.leandroadal.vortasks.controllers.exceptions.StandardError;
import com.leandroadal.vortasks.controllers.exceptions.ValidationError;
import com.leandroadal.vortasks.entities.shop.dto.CategoryResponseDTO;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;

@Target({ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
public @interface CategoryDocSwagger {

    @Target({ElementType.METHOD})
    @Retention(RetentionPolicy.RUNTIME)
    @Operation(summary = "Criar categoria (ADMIN)", description = "Cria uma nova categoria para produtos")
    @ApiResponses(value = {
        @ApiResponse(responseCode = "201", description = "Categoria criada com sucesso", content = { @Content(mediaType = "application/json", 
        schema = @Schema(implementation = CategoryResponseDTO.class)) }),
        @ApiResponse(responseCode = "400", description = "Erro de validação",
                content = @Content(mediaType = "application/json", schema = @Schema(oneOf = {StandardError.class, ValidationError.class}))),
        @ApiResponse(responseCode = "403", description = "Acesso negado", 
                content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class))),
        @ApiResponse(responseCode = "500", description = "Erro interno no servidor",
                content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)))
    })
    @SecurityRequirement(name = "bearerAuth")
    @interface CreateCategorySwagger {
    }

    @Target({ElementType.METHOD})
    @Retention(RetentionPolicy.RUNTIME)
    @Operation(summary = "Buscar categoria por ID", description = "Busca uma categoria pelo seu ID")
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "Categoria encontrada com sucesso", content = { @Content(mediaType = "application/json", 
        schema = @Schema(implementation = CategoryResponseDTO.class)) }),
        @ApiResponse(responseCode = "404", description = "Categoria não encontrada",
                content = {@Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class))}),
        @ApiResponse(responseCode = "500", description = "Erro interno no servidor",
                content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)))
    })
    @SecurityRequirement(name = "bearerAuth")
    @interface GetCategorySwagger {
    }

    @Target({ElementType.METHOD})
    @Retention(RetentionPolicy.RUNTIME)
    @Operation(summary = "Listar todas as categorias (ADMIN)", description = "Lista todas as categorias de produtos")
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "Categorias listadas com sucesso", content = { @Content(mediaType = "application/json", 
        schema = @Schema(implementation = CategoryResponseDTO[].class)) }),
        @ApiResponse(responseCode = "403", description = "Acesso negado", 
                content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class))),
        @ApiResponse(responseCode = "500", description = "Erro interno no servidor",
                content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)))
    })
    @SecurityRequirement(name = "bearerAuth")
    @interface GetAllCategorySwagger {
    }

    @Target({ElementType.METHOD})
    @Retention(RetentionPolicy.RUNTIME)
    @Operation(summary = "Editar categoria (ADMIN)", description = "Edita uma categoria existente")
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "Categoria editada com sucesso", content = { @Content(mediaType = "application/json", 
        schema = @Schema(implementation = CategoryResponseDTO.class)) }),
        @ApiResponse(responseCode = "400", description = "Erro de validação",
                content = @Content(mediaType = "application/json", schema = @Schema(oneOf = {StandardError.class, ValidationError.class}))),
        @ApiResponse(responseCode = "403", description = "Acesso negado", 
                content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class))),
        @ApiResponse(responseCode = "404", description = "Categoria não encontrada",
                content = {@Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class))}),
        @ApiResponse(responseCode = "500", description = "Erro interno no servidor",
                content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)))
    })
    @SecurityRequirement(name = "bearerAuth")
    @interface EditCategorySwagger {
    }

    @Target({ElementType.METHOD})
    @Retention(RetentionPolicy.RUNTIME)
    @Operation(summary = "Excluir categoria (ADMIN)", description = "Exclui uma categoria existente")
    @ApiResponses(value = {
        @ApiResponse(responseCode = "204", description = "Categoria excluída com sucesso"),
        @ApiResponse(responseCode = "404", description = "Categoria não encontrada",
                content = {@Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class))}),
        @ApiResponse(responseCode = "500", description = "Erro interno no servidor",
                content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)))
    })
    @SecurityRequirement(name = "bearerAuth")
    @interface DeleteCategorySwagger {
    }

}
