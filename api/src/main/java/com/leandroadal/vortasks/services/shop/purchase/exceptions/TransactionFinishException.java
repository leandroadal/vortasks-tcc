package com.leandroadal.vortasks.services.shop.purchase.exceptions;

public class TransactionFinishException extends RuntimeException {

    public TransactionFinishException(String message) {
        super("A transação com ID: '" + message + "' ja foi finalizada!");
    }
}
