package com.leandroadal.vortasks.entities.shop.dto;

import java.util.List;
import java.util.stream.Collectors;

import com.leandroadal.vortasks.entities.shop.product.Category;
import com.leandroadal.vortasks.entities.shop.product.Product;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

public record ProductRequestDTO(
        @NotBlank(message = "O nome não pode estar em branco") 
        String name,

        @NotBlank(message = "A descrição não pode estar em branco") 
        String description,

        @NotNull(message = "O tipo de produto não pode ser nulo") 
        List<Integer> categoriesId,

        @NotBlank(message = "O ícone não pode estar em branco") 
        String icon,

        @Min(value = 0, message = "As moedas devem ser um número maior ou igual a zero") 
        Integer coins,

        @Min(value = 0, message = "As moedas devem ser um número maior ou igual a zero") 
        Integer gems,

        Boolean active) {

    public Product toProduct() {
        Product data = new Product();
        data.setName(name);
        data.setDescription(description);
        data.setIcon(icon);
        data.setCoins(coins);
        data.setGems(gems);
        
        data.getCategories().addAll(categoriesId.stream().map(catId -> {
            Category category = new Category();
            category.setId(catId);
            return category;
        }).collect(Collectors.toSet()));
        
        return data;
    }

}
