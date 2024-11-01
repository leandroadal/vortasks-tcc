package com.leandroadal.vortasks.controllers.shop.purchase.doc;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import com.leandroadal.vortasks.controllers.exceptions.StandardError;
import com.leandroadal.vortasks.controllers.exceptions.ValidationError;
import com.leandroadal.vortasks.entities.shop.dto.GemsTransactionDTO;
import com.leandroadal.vortasks.entities.shop.dto.ProductTransactionDTO;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;

@Target({ ElementType.METHOD })
@Retention(RetentionPolicy.RUNTIME)
public @interface PurchaseDocSwagger {

    @Target({ ElementType.METHOD })
    @Retention(RetentionPolicy.RUNTIME)
    @Operation(summary = "Iniciar compra de gemas", description = "Inicia uma compra de gemas, retornando o ID da transação")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "Compra de gemas iniciada com sucesso", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = GemsTransactionDTO.class)) }),
            @ApiResponse(responseCode = "400", description = "Dados de compra inválidos",
                content = @Content(mediaType = "application/json", schema = @Schema(oneOf = {StandardError.class, ValidationError.class}))),
            @ApiResponse(responseCode = "404", description = "Pacote de gemas não encontrado", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor", content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class))) })
    @SecurityRequirement(name = "bearerAuth")
    @interface StartGemsPurchaseSwagger {
    }

    @Target({ ElementType.METHOD })
    @Retention(RetentionPolicy.RUNTIME)
    @Operation(summary = "Concluir compra de gemas", description = "Conclui uma compra de gemas, utilizando o ID da transação e o token de pagamento")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Compra de gemas concluída com sucesso"),
            @ApiResponse(responseCode = "400", description = "Dados de compra inválidos", 
                content = @Content(mediaType = "application/json", schema = @Schema(oneOf = {ValidationError.class, StandardError.class}))),
            @ApiResponse(responseCode = "404", description = "Transação de gemas não encontrada", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "409", description = "Transação já finalizada", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor", content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class))) })
    @SecurityRequirement(name = "bearerAuth")
    @interface CompleteGemsPurchaseSwagger {
    }

    @Target({ ElementType.METHOD })
    @Retention(RetentionPolicy.RUNTIME)
    @Operation(summary = "Cancelar compra de gemas", description = "Cancela uma compra de gemas, utilizando o ID da transação")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Compra de gemas cancelada com sucesso"),
            @ApiResponse(responseCode = "403", description = "Acesso negado", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "404", description = "Transação de gemas não encontrada", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor", content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class))) })
    @SecurityRequirement(name = "bearerAuth")
    @interface CancelGemsPurchaseSwagger {
    }

    @Target({ ElementType.METHOD })
    @Retention(RetentionPolicy.RUNTIME)
    @Operation(summary = "Comprar produto", description = "Compra um produto utilizando moedas e gemas.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "Compra de produto realizada com sucesso", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = ProductTransactionDTO.class)) }),
            @ApiResponse(responseCode = "400", description = "Dados de compra inválidos", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "400", description = "Saldo insuficiente para compra do produto",
                content = @Content(mediaType = "application/json", schema = @Schema(oneOf = {ValidationError.class, StandardError.class}))),
                    @ApiResponse(responseCode = "403", description = "Acesso negado", content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class))),
            @ApiResponse(responseCode = "404", description = "Produto não encontrado", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor", content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class))) })
    @SecurityRequirement(name = "bearerAuth")
    @interface ProductPurchaseSwagger {
    }

}