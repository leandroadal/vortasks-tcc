package com.leandroadal.vortasks.controllers.shop.products;

import java.net.URI;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.leandroadal.vortasks.controllers.shop.products.doc.CategoryDocSwagger;
import com.leandroadal.vortasks.entities.shop.dto.CategoryRequestDTO;
import com.leandroadal.vortasks.entities.shop.dto.CategoryResponseDTO;
import com.leandroadal.vortasks.entities.shop.product.Category;
import com.leandroadal.vortasks.services.shop.products.CategoryService;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import org.springframework.web.bind.annotation.RequestMapping;


@RestController
@RequestMapping(value = "/shop/category")
public class CategoryController {

    @Autowired
    private CategoryService service;

    @GetMapping("/{id}")
    @CategoryDocSwagger.GetCategorySwagger
    public ResponseEntity<CategoryResponseDTO> getCategory(@PathVariable @NotNull @Positive Integer id) {
        Category product = service.categoryById(id);
        return ResponseEntity.ok(new CategoryResponseDTO(product));
    }

    // ================= ADMIN ===================
    
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    @PostMapping
    @CategoryDocSwagger.CreateCategorySwagger
    public ResponseEntity<CategoryResponseDTO> createCategory(@Valid @RequestBody CategoryRequestDTO categoryDTO) {
        Category data = categoryDTO.toCategory();
        Category newCategory = service.addCategory(data);

        URI uri = ServletUriComponentsBuilder.fromCurrentRequest()
                .replacePath("/shop/category/{id}")
                .buildAndExpand(newCategory.getId())
                .toUri();
        return ResponseEntity.created(uri).body(new CategoryResponseDTO(newCategory));
    }

    @PreAuthorize("hasRole('ROLE_ADMIN')")
    @GetMapping
    @CategoryDocSwagger.GetAllCategorySwagger
    public ResponseEntity<List<CategoryResponseDTO>> getAllCategory() {
        List<Category> products = service.getAllCategories();
        return ResponseEntity.ok(products.stream()
                .map(CategoryResponseDTO::new)
                .toList());
    }

    @PreAuthorize("hasRole('ROLE_ADMIN')")
    @PutMapping("/{id}")
    @CategoryDocSwagger.EditCategorySwagger
    public ResponseEntity<CategoryResponseDTO> editCategory(@PathVariable @Positive Integer id, @Valid @RequestBody CategoryRequestDTO productDTO) {
        Category data = productDTO.toCategory();
        data.setId(id);
        Category product = service.editCategory(data);
        return ResponseEntity.ok(new CategoryResponseDTO(product));
    }

    @PreAuthorize("hasRole('ROLE_ADMIN')")
    @DeleteMapping("/{id}")
    @CategoryDocSwagger.DeleteCategorySwagger
    public ResponseEntity<String> deleteCategory(@PathVariable @Positive Integer id) {
        service.deleteCategory(id);
        return ResponseEntity.noContent().build();
    }
}
