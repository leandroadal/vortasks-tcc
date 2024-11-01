package com.leandroadal.vortasks.entities.shop.dto;

import java.util.List;

public record TransactionResponseDTO(
        List<GemsTransactionDTO> gemsTransactions,
        List<ProductTransactionDTO> productsTransactions){

}
