package com.leandroadal.vortasks.entities.shop.transaction;

import java.math.BigDecimal;

import com.leandroadal.vortasks.entities.shop.enumerators.PaymentStatus;
import com.leandroadal.vortasks.entities.shop.product.GemsPackage;

import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class GemsTransaction extends AbstractTransaction {
    
    @Enumerated(EnumType.STRING)
    private PaymentStatus status;
    
    private BigDecimal price;

    @ManyToOne
    @JoinColumn(name = "currency_sell_id")
    private GemsPackage gemsPackage;

}
