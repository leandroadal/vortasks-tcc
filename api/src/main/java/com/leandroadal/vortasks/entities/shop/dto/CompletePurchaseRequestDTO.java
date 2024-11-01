package com.leandroadal.vortasks.entities.shop.dto;

import java.math.BigDecimal;

import org.hibernate.validator.constraints.UUID;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;

public record CompletePurchaseRequestDTO(
    @NotNull(message = "O ID da transação de gemas não pode ser nulo")
    @UUID
    String gemsTransactionId,

    @NotNull(message = "O token de pagamento não pode ser nulo")
    @Positive(message = "O token de pagamento deve ser um valor positivo")
    BigDecimal paymentToken
) {

}
