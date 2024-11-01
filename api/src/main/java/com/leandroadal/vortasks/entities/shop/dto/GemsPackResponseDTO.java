package com.leandroadal.vortasks.entities.shop.dto;

import java.math.BigDecimal;

import com.leandroadal.vortasks.entities.shop.product.GemsPackage;

public record GemsPackResponseDTO(
        Long id,
        String nameOfPackage,
        String icon,
        int gems,
        BigDecimal money,
        float discountPercentage,
        BigDecimal totalPrice) {
            
    public GemsPackResponseDTO(GemsPackage gemsPackage) {
        this(
                gemsPackage.getId(),
                gemsPackage.getNameOfPackage(),
                gemsPackage.getIcon(),
                gemsPackage.getGems(),
                gemsPackage.getMoney(),
                gemsPackage.getDiscountPercentage(),
                gemsPackage.priceWithDiscount());
    }
}
