package com.leandroadal.vortasks.repositories.shop;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import com.leandroadal.vortasks.entities.shop.product.Category;
import com.leandroadal.vortasks.entities.shop.product.Product;

public interface ProductRepository extends JpaRepository<Product, Long> {

    Page<Product> findDistinctByNameContainingAndActiveTrue(String name, Pageable pageable);
    Page<Product> findDistinctByNameContainingAndCategoriesInAndActiveTrue(String name, List<Category> category, Pageable pageable);
    List<Product> findAllByActiveTrue();
    List<Product> findAllByActiveFalse();
}
