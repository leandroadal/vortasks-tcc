package com.leandroadal.vortasks.controllers.shop.products.doc;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import com.leandroadal.vortasks.controllers.exceptions.StandardError;
import com.leandroadal.vortasks.controllers.exceptions.ValidationError;
import com.leandroadal.vortasks.entities.shop.dto.ProductResponseDTO;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.ArraySchema;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;

@Target({ ElementType.METHOD })
@Retention(RetentionPolicy.RUNTIME)
public @interface ProductDocSwagger {

    @Target({ ElementType.METHOD })
    @Retention(RetentionPolicy.RUNTIME)
    @Operation(summary = "Listar produtos comprados", description = "Lista todos os produtos comprados pelo usuário")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Produtos comprados listados com sucesso", content = {
                    @Content(mediaType = "application/json", array = @ArraySchema(schema = @Schema(implementation = ProductResponseDTO.class))) }),
            @ApiResponse(responseCode = "403", description = "Acesso negado", content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class))),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor", content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class))) })
    @SecurityRequirement(name = "bearerAuth")
    @interface GetPurchasedProductsSwagger {
    }

    @Target({ ElementType.METHOD })
    @Retention(RetentionPolicy.RUNTIME)
    @Operation(summary = "Listar produtos por página", description = "Lista produtos por página, com filtros opcionais de nome e categoria")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Produtos listados com sucesso", content = {
                    @Content(mediaType = "application/json") }),
            @ApiResponse(responseCode = "400", description = "Parâmetros de paginação inválidos", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor", content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class))) })
    @interface FindPageProductSwagger {
    }

    @Target({ ElementType.METHOD })
    @Retention(RetentionPolicy.RUNTIME)
    @Operation(summary = "Buscar produto por ID", description = "Busca um produto pelo seu ID")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Produto encontrado com sucesso", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = ProductResponseDTO.class)) }),
            @ApiResponse(responseCode = "404", description = "Produto não encontrado", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor", content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class))) })
    @interface GetProductSwagger {
    }

    // ============== ADMIN ==============

    @Target({ ElementType.METHOD })
    @Retention(RetentionPolicy.RUNTIME)
    @Operation(summary = "Criar produto (ADMIN)", description = "Cria um novo produto na loja")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "Produto criado com sucesso", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = ProductResponseDTO.class)) }),
            @ApiResponse(responseCode = "400", description = "Erro de validação",
                    content = @Content(mediaType = "application/json", schema = @Schema(oneOf = {StandardError.class, ValidationError.class}))),
            @ApiResponse(responseCode = "403", description = "Acesso negado", content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class))),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor", content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class))) })
    @SecurityRequirement(name = "bearerAuth")
    @interface CreateProductSwagger {
    }

    @Target({ ElementType.METHOD })
    @Retention(RetentionPolicy.RUNTIME)
    @Operation(summary = "Editar produto (ADMIN)", description = "Edita um produto existente")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Produto editado com sucesso", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = ProductResponseDTO.class)) }),
            @ApiResponse(responseCode = "400", description = "Erro de validação",
                    content = @Content(mediaType = "application/json", schema = @Schema(oneOf = {StandardError.class, ValidationError.class}))),
            @ApiResponse(responseCode = "403", description = "Acesso negado", content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class))),
            @ApiResponse(responseCode = "404", description = "Produto não encontrado", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor", content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class))) })
    @SecurityRequirement(name = "bearerAuth")
    @interface EditProductSwagger {
    }

    @Target({ ElementType.METHOD })
    @Retention(RetentionPolicy.RUNTIME)
    @Operation(summary = "Editar parcialmente produto (ADMIN)", description = "Edita parcialmente um produto existente")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Produto editado com sucesso"),
            @ApiResponse(responseCode = "403", description = "Acesso negado", content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class))),
            @ApiResponse(responseCode = "404", description = "Produto não encontrado", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor", content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class))) })
    @SecurityRequirement(name = "bearerAuth")
    @interface PartialEditProductSwagger {
    }

    @Target({ ElementType.METHOD })
    @Retention(RetentionPolicy.RUNTIME)
    @Operation(summary = "Excluir produto (ADMIN)", description = "Exclui um produto existente")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "204", description = "Produto excluído com sucesso"),
            @ApiResponse(responseCode = "404", description = "Produto não encontrado", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor", content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class))) })
    @SecurityRequirement(name = "bearerAuth")
    @interface DeleteProductSwagger {
    }

    @Target({ ElementType.METHOD })
    @Retention(RetentionPolicy.RUNTIME)
    @Operation(summary = "Desativar produto (ADMIN)", description = "Desativa um produto existente")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "204", description = "Produto desativado com sucesso"),
            @ApiResponse(responseCode = "403", description = "Acesso negado", content = 
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class))),
            @ApiResponse(responseCode = "404", description = "Produto não encontrado", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor", content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class))) })
    @SecurityRequirement(name = "bearerAuth")
    @interface DesativeProductSwagger {
    }

    @Target({ ElementType.METHOD })
    @Retention(RetentionPolicy.RUNTIME)
    @Operation(summary = "Atualizar categorias de um produto (ADMIN)", description = "Atualiza as categorias de um produto existente")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "204", description = "Categorias do produto atualizadas com sucesso"),
            @ApiResponse(responseCode = "400", description = "Erro de validação",
                content = @Content(mediaType = "application/json", schema = @Schema(oneOf = {StandardError.class, ValidationError.class}))),
            @ApiResponse(responseCode = "403", description = "Acesso negado ou Token invalido"),
            @ApiResponse(responseCode = "404", description = "Produto não encontrado", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor", content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class))) })
    @SecurityRequirement(name = "bearerAuth")
    @interface UpdateProductCategorySwagger {
    }

    @Target({ ElementType.METHOD })
    @Retention(RetentionPolicy.RUNTIME)
    @Operation(summary = "Remover categorias de um produto (ADMIN)", description = "Remove categorias de um produto existente")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "204", description = "Categorias do produto removidas com sucesso"),
            @ApiResponse(responseCode = "403", description = "Acesso negado", content = @Content(mediaType = "application/json")),
            @ApiResponse(responseCode = "404", description = "Produto não encontrado", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor", content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class))) })
    @SecurityRequirement(name = "bearerAuth")
    @interface DeleteProductCategorySwagger {
    }

}
