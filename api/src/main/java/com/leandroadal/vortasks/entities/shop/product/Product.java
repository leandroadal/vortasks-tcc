package com.leandroadal.vortasks.entities.shop.product;

import java.util.HashSet;
import java.util.Set;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.Table;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "product")
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(unique = true)
    private String name;

    private String description;
    private String icon;
    private Integer coins;
    private Integer gems;
    private Integer totalSales;
    private Boolean active;

    @JoinTable(
      name = "product_category", 
      joinColumns = @JoinColumn(name = "product_id"), 
      inverseJoinColumns = @JoinColumn(name = "category_id"))
    @ManyToMany(cascade = CascadeType.ALL)
    @Setter(AccessLevel.NONE)
    private Set<Category> categories = new HashSet<>();

    public void sell(){
        this.totalSales++;
    }
}
