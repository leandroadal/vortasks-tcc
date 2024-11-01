package com.leandroadal.vortasks.controllers.social.doc;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;
import com.leandroadal.vortasks.controllers.exceptions.StandardError;
import com.leandroadal.vortasks.entities.social.friend.dto.FriendDataDTO;
import com.leandroadal.vortasks.entities.social.friend.dto.FriendshipDTO;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.ArraySchema;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;

@Target({ ElementType.METHOD })
@Retention(RetentionPolicy.RUNTIME)
public @interface FriendshipDocSwagger {

    @Target({ ElementType.METHOD })
    @Retention(RetentionPolicy.RUNTIME)
    @Operation(summary = "Listar amigos", description = "Lista todos os amigos do usuário")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Amigos listados com sucesso", content = {
                    @Content(mediaType = "application/json", array = @ArraySchema(schema = @Schema(implementation = FriendshipDTO.class))) }),
            @ApiResponse(responseCode = "403", description = "Acesso negado", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor", content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class))) })
    @SecurityRequirement(name = "bearerAuth")
    @interface GetFriendsSwagger {
    }

    @Target({ ElementType.METHOD })
    @Retention(RetentionPolicy.RUNTIME)
    @Operation(summary = "Obter dados do amigo", description = "Retorna o nome de usuário e o nível de um amigo em uma amizade específica.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Dados do amigo encontrados com sucesso", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = FriendDataDTO.class)) }),
            @ApiResponse(responseCode = "403", description = "Acesso negado. Usuário não é amigo do usuário solicitado.", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "404", description = "Amizade ou amigo não encontrado", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }) })
    @SecurityRequirement(name = "bearerAuth")
    @interface GetFriendDataSwagger {
    }

    @Target({ ElementType.METHOD })
    @Retention(RetentionPolicy.RUNTIME)
    @Operation(summary = "Excluir amizade", description = "Exclui uma amizade existente")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "204", description = "Amizade excluída com sucesso"),
            @ApiResponse(responseCode = "403", description = "Acesso negado", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "404", description = "Amizade não encontrada", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor", content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class))) })
    @SecurityRequirement(name = "bearerAuth")
    @interface DeleteFriendshipSwagger {
    }

}