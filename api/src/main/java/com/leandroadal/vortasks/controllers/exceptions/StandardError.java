package com.leandroadal.vortasks.controllers.exceptions;

import java.time.Instant;

import com.fasterxml.jackson.annotation.JsonFormat;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class StandardError {

    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd'T'HH:mm:ss'Z'", timezone = "GMT")
    private Instant timestamp;
    
    @Schema(description = "Código HTTP do erro")
    private Integer status;

    @Schema(description = "Nome do erro")
    private String error;

    @Schema(description = "Mensagem de erro")
    private String message;

    @Schema(description = "Caminho da requisição")
    private String path;

}
