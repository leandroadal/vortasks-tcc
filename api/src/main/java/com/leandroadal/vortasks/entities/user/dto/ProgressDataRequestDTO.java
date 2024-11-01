package com.leandroadal.vortasks.entities.user.dto;

import java.time.Instant;

import com.leandroadal.vortasks.entities.user.ProgressData;

import jakarta.validation.constraints.Min;

public record ProgressDataRequestDTO(
    @Min(value = 0, message = "A quantidade de moedas deve ser um número maior ou igual a zero")
    Integer coins,
    
    @Min(value = 0, message = "A quantidade de gemas deve ser um número maior ou igual a zero")
    Integer gems,
    
    @Min(value = 0, message = "O nível deve ser um número maior ou igual a zero")
    Integer level,
    
    @Min(value = 0, message = "A experiência deve ser um número maior ou igual a zero")
    Float xp,

    Instant lastModified
) {
    public ProgressData toProgressData(String id) {
        return new ProgressData(id, coins, gems, level, xp, lastModified, null);
    }
    
}
