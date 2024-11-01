package com.leandroadal.vortasks.entities.shop.dto;

import java.util.Set;
import java.util.stream.Collectors;

import com.leandroadal.vortasks.entities.shop.product.Product;

public record ProductResponseDTO(
        Long id,
        String name,
        String description,
        Set<CategoryResponseDTO> category,
        String icon,
        int coins,
        int gems,
        int totalSales) {

    public ProductResponseDTO(Product data) {
        this(
            data.getId(), 
            data.getName(), 
            data.getDescription(),
            data.getCategories().stream().map(CategoryResponseDTO::new).collect(Collectors.toSet()),
            data.getIcon(),
            data.getCoins(), 
            data.getGems(), 
            data.getTotalSales());
    }
}
