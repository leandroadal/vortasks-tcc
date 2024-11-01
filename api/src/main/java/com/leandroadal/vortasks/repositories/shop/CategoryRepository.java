package com.leandroadal.vortasks.repositories.shop;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.leandroadal.vortasks.entities.shop.product.Category;

public interface CategoryRepository extends JpaRepository<Category, Integer> {

    List<Category> findAllByIdIn(List<Integer> categoryIds);

}
