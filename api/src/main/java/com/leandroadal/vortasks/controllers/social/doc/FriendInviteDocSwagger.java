package com.leandroadal.vortasks.controllers.social.doc;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;
import com.leandroadal.vortasks.controllers.exceptions.StandardError;
import com.leandroadal.vortasks.entities.social.friend.dto.FriendInviteResponseDTO;
import com.leandroadal.vortasks.entities.social.friend.dto.FriendshipDTO;
import com.leandroadal.vortasks.services.social.friendship.exceptions.FriendException;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.ArraySchema;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;

@Target({ ElementType.METHOD })
@Retention(RetentionPolicy.RUNTIME)
public @interface FriendInviteDocSwagger {

    @Target({ ElementType.METHOD })
    @Retention(RetentionPolicy.RUNTIME)
    @Operation(summary = "Buscar convite de amizade", description = "Busca um convite de amizade entre dois usuários")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Convite de amizade encontrado com sucesso", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = FriendInviteResponseDTO.class)) }),
            @ApiResponse(responseCode = "403", description = "Acesso negado", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "404", description = "Convite de amizade não encontrado", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor", content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class))) })
    @SecurityRequirement(name = "bearerAuth")
    @interface GetFriendInviteSwagger {
    }

    @Target({ ElementType.METHOD })
    @Retention(RetentionPolicy.RUNTIME)
    @Operation(summary = "Listar meus convites de amizade", description = "Lista todos os convites de amizade pendentes que o usuário recebeu ou enviou")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Convites de amizade listados com sucesso", content = {
                    @Content(mediaType = "application/json", array = @ArraySchema(schema = @Schema(implementation = FriendInviteResponseDTO.class))) }),
            @ApiResponse(responseCode = "403", description = "Acesso negado", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor", content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class))) })
    @SecurityRequirement(name = "bearerAuth")
    @interface GetMyFriendInviteSwagger {
    }

    @Target({ ElementType.METHOD })
    @Retention(RetentionPolicy.RUNTIME)
    @Operation(summary = "Enviar convite de amizade", description = "Envia um convite de amizade para outro usuário")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Convite de amizade enviado com sucesso", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = FriendInviteResponseDTO.class)) }),
            @ApiResponse(responseCode = "403", description = "Acesso negado", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "404", description = "Usuário destinatário não encontrado", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "409", description = "Convite de amizade já existente", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = FriendException.class)) }),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor", content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class))) })
    @SecurityRequirement(name = "bearerAuth")
    @interface SendFriendRequestSwagger {
    }

    @Target({ ElementType.METHOD })
    @Retention(RetentionPolicy.RUNTIME)
    @Operation(summary = "Aceitar convite de amizade", description = "Aceita um convite de amizade recebido")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Convite de amizade aceito com sucesso", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = FriendshipDTO.class)) }),
            @ApiResponse(responseCode = "403", description = "Acesso negado ou usuário incompatível com o convite", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "404", description = "Convite de amizade não encontrado", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),

            @ApiResponse(responseCode = "409", description = "Convite de amizade já foi rejeitado", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = FriendException.class)) }),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor", content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class))) })
    @SecurityRequirement(name = "bearerAuth")
    @interface AcceptFriendRequestSwagger {
    }

    @Target({ ElementType.METHOD })
    @Retention(RetentionPolicy.RUNTIME)
    @Operation(summary = "Recusar convite de amizade", description = "Recusa um convite de amizade recebido")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "204", description = "Convite de amizade recusado com sucesso"),
            @ApiResponse(responseCode = "403", description = "Acesso negado ou usuário incompatível com o convite", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "404", description = "Convite de amizade não encontrado", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor", content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class))) })
    @SecurityRequirement(name = "bearerAuth")
    @interface RefusedFriendInviteSwagger {
    }

    @Target({ ElementType.METHOD })
    @Retention(RetentionPolicy.RUNTIME)
    @Operation(summary = "Cancelar convite de amizade", description = "Cancela um convite de amizade enviado")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "204", description = "Convite de amizade cancelado com sucesso"),
            @ApiResponse(responseCode = "403", description = "Acesso negado ou usuário incompatível com o convite", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "404", description = "Convite de amizade não encontrado", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class)) }),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor", content = @Content(mediaType = "application/json", schema = @Schema(implementation = StandardError.class))) })
    @SecurityRequirement(name = "bearerAuth")
    @interface CancelFriendInviteSwagger {
    }

}