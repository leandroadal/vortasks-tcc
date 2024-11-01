package com.leandroadal.vortasks.entities.shop.transaction;

import java.time.Instant;

import com.leandroadal.vortasks.entities.user.User;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Inheritance;
import jakarta.persistence.InheritanceType;
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
@Inheritance(strategy = InheritanceType.JOINED)
public abstract class AbstractTransaction {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private String id;

    private Instant purchaseDate;
    private String errorMessage;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

}
