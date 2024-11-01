package com.leandroadal.vortasks.services.shop.purchase;

import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class LogPurchase {

    // --------------- Gems ---------------

    public void gemsTransactionNotFound(String gemsTransactionId) {
        log.error("Transação de compra de Gems como ID: {} não encontrada!", gemsTransactionId);
    }

    public void createGemsTransaction(String id) {
        log.info("Criada a transação de compra de Gems com ID: " + id);;
    }

    protected void cancelGemsTransaction(String id) {
        log.info("Cancelada a transação de compra de Gems com ID: " + id);
    }

    protected void declinedGemsTransaction(String id) {
        log.info("Negada a transação de compra de Gems com ID: " + id);
    }

    protected void errorGemsTransaction(String id) {
        log.error("Erro na transação de compra de Gems com ID: " + id);
    }

    // ---------------  Products ---------------

    protected void productTransactionNotFound(String transactionId) {
        log.error("Transação de compra de Produto com o ID: " + transactionId + " não encontrada!");
    }

    public void createProductTransaction(String transactionId) {
        log.info("Transação de compra de Produto com o ID: " + transactionId + " foi criada!");
    }

    protected void NotEnoughCoinsAndGems(Long id) {
        log.error("Saldo insuficiente para o produto que possui o ID: {}", id);;
    }

}
