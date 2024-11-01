package com.leandroadal.vortasks.entities.shop.product;

import java.math.BigDecimal;
import java.math.RoundingMode;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@Entity
@NoArgsConstructor
@AllArgsConstructor
public class GemsPackage {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true)
    private String nameOfPackage;
    
    private String icon;
    private Integer gems;
    private BigDecimal money;
    private Float discountPercentage;
    private int totalSales;

    public BigDecimal priceWithDiscount() {
        BigDecimal totalPrice = money;
        BigDecimal discountAmount = totalPrice.multiply(BigDecimal.valueOf(discountPercentage / 100));
        BigDecimal totalPriceWithDiscount = totalPrice.subtract(discountAmount);
        return totalPriceWithDiscount.setScale(2, RoundingMode.HALF_UP);
    }

    public void sell(){
        this.totalSales++;
    }
}
