package com.leandroadal.vortasks.entities.shop.transaction;

import com.leandroadal.vortasks.entities.shop.product.Product;

import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class ProductTransaction extends AbstractTransaction {

    private Integer priceInCoins;
    private Integer priceInGems;

    @ManyToOne
    @JoinColumn(name = "product_id")
    private Product product;

}
