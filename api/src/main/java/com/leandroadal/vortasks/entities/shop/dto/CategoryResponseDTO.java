package com.leandroadal.vortasks.entities.shop.dto;

import com.leandroadal.vortasks.entities.shop.product.Category;

public record CategoryResponseDTO(
    int id,
    String name,
    int totalProductCount
) {

    public CategoryResponseDTO(Category category) {
        this(
            category.getId(), 
            category.getName(), 
            category.totalProducts());

    }


}
