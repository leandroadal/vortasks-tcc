package com.leandroadal.vortasks.entities.shop.dto;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;

public record StartPurchaseRequestDTO(
    @NotNull(message = "O Id não pode ser nulo")
    @Positive(message = "O deve deve ser um numero positivo")
    Long productOrGemsId
) {

}
