package com.leandroadal.vortasks.entities.shop.dto;

import com.leandroadal.vortasks.entities.shop.product.Category;

import jakarta.validation.constraints.NotBlank;

public record CategoryRequestDTO(
    @NotBlank(message = "O nome não pode estar em branco")
    String name
) {

    public Category toCategory() {
        Category data = new Category();
        data.setName(name);
        return data;
    }

}
