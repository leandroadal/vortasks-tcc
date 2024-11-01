package com.leandroadal.vortasks.entities.shop.dto;

import java.math.BigDecimal;
import java.time.Instant;

import org.hibernate.validator.constraints.UUID;

import com.leandroadal.vortasks.entities.shop.enumerators.PaymentStatus;
import com.leandroadal.vortasks.entities.shop.transaction.GemsTransaction;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;

public record GemsTransactionDTO(
    @UUID
    String id,
    
    @NotNull(message = "O status não pode ser nulo")
    PaymentStatus status,
    
    @Positive(message = "O preço deve ser maior que zero")
    BigDecimal price,
    
    @NotNull(message = "A data de compra não pode ser nula")
    Instant purchaseDate,
    
    String errorMessage
) {
    public GemsTransactionDTO(GemsTransaction data) {
        this(
                data.getId(),
                data.getStatus(),
                data.getPrice(),
                data.getPurchaseDate(),
                data.getErrorMessage()
        );
    }
}
