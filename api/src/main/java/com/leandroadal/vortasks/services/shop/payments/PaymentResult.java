package com.leandroadal.vortasks.services.shop.payments;

public class PaymentResult {

    private boolean success;
    private String errorMessage;

    public PaymentResult() {
        this.success = true;
    }

    public PaymentResult(String errorMessage) {
        this.success = false;
        this.errorMessage = errorMessage;
    }

    public boolean isSuccess() {
        return success;
    }

    public String getErrorMessage() {
        return errorMessage;
    }
}

