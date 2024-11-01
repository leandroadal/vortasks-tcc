package com.leandroadal.vortasks.repositories.shop;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.leandroadal.vortasks.entities.shop.transaction.GemsTransaction;

public interface GemsTransactionRepository extends JpaRepository<GemsTransaction, String> {

    List<GemsTransaction> findAllByUserId(String userId);

    GemsTransaction findByUserId(String userId);

}
