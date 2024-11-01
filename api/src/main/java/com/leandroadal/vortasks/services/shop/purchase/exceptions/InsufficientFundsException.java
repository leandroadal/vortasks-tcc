package com.leandroadal.vortasks.services.shop.purchase.exceptions;

public class InsufficientFundsException extends RuntimeException {

    public InsufficientFundsException(String id) {
        super("Saldo insuficiente para o item que possui o ID: "+ id);
    }

    public InsufficientFundsException(Long id) {
        super("Saldo insuficiente para o item que possui o ID: "+ id);
    }
}
