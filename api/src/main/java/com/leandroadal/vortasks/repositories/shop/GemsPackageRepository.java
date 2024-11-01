package com.leandroadal.vortasks.repositories.shop;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import com.leandroadal.vortasks.entities.shop.product.GemsPackage;

public interface GemsPackageRepository extends JpaRepository<GemsPackage, Long> {

    Page<GemsPackage> findDistinctByNameOfPackageContaining(String nameOfPackage, Pageable pageable);
}
