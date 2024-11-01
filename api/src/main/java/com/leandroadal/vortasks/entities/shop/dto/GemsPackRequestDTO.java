package com.leandroadal.vortasks.entities.shop.dto;

import java.math.BigDecimal;

import com.leandroadal.vortasks.entities.shop.product.GemsPackage;
import com.leandroadal.vortasks.services.shop.validation.PercentageRange;

import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;

public record GemsPackRequestDTO(
        @NotBlank(message = "O nome do pacote de gemas não pode estar em branco") String nameOfPackage,

        @NotBlank(message = "O ícone não pode estar em branco") 
        String icon,

        @NotNull(message = "O valor não pode ser nulo")
        @Positive(message = "O número de gemas deve ser positivo") 
        Integer gems,

        @NotNull(message = "O valor não pode ser nulo")
        @DecimalMin(value = "0.0", inclusive = false, message = "O valor do dinheiro deve ser maior que zero") 
        BigDecimal money,

        @PercentageRange(min = 0.0f, max = 100.0f) 
        Float discountPercentage) {

    public GemsPackage toGemsPackage() {
        GemsPackage newPackage = new GemsPackage();
        newPackage.setNameOfPackage(nameOfPackage);
        newPackage.setIcon(icon);
        newPackage.setGems(gems);
        newPackage.setMoney(money);
        newPackage.setDiscountPercentage(discountPercentage);
        return newPackage;
    }

}
