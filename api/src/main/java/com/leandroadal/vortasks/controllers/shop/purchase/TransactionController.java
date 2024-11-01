package com.leandroadal.vortasks.controllers.shop.purchase;

import java.util.Collections;
import java.util.List;
import org.hibernate.validator.constraints.UUID;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.leandroadal.vortasks.controllers.shop.purchase.doc.TransactionDocSwagger;
import com.leandroadal.vortasks.entities.shop.dto.GemsTransactionDTO;
import com.leandroadal.vortasks.entities.shop.dto.ProductTransactionDTO;
import com.leandroadal.vortasks.entities.shop.dto.TransactionResponseDTO;
import com.leandroadal.vortasks.entities.shop.transaction.GemsTransaction;
import com.leandroadal.vortasks.entities.shop.transaction.ProductTransaction;
import com.leandroadal.vortasks.services.shop.purchase.TransactionService;

@RestController
@RequestMapping("/shop/my-transactions")
public class TransactionController {

    @Autowired
    private TransactionService service;

    @GetMapping("/gems/{id}")
    @TransactionDocSwagger.GetGemsTransactionSwagger
    public ResponseEntity<GemsTransactionDTO> getGemsTransaction(@PathVariable @UUID String id) {
        GemsTransaction gems = service.findGemsTransaction(id);
        return ResponseEntity.ok().body(new GemsTransactionDTO(gems));
    }

    @GetMapping("/product/{id}")
    @TransactionDocSwagger.GetProductTransactionSwagger
    public ResponseEntity<ProductTransactionDTO> getProductTransaction(@PathVariable @UUID String id) {
        ProductTransaction product = service.findProductTransaction(id);
        return ResponseEntity.ok().body(new ProductTransactionDTO(product));
    }

    @GetMapping
    @TransactionDocSwagger.MyTransactionsSwagger
    public ResponseEntity<TransactionResponseDTO> myTransactions() {
        List<ProductTransaction> productList = service.myProductListTransaction();
        List<GemsTransaction> gemsList = service.myGemsListTransaction();

        List<ProductTransactionDTO> productsDTOs = productList.stream()
                .map(ProductTransactionDTO::new)
                .toList();

        List<GemsTransactionDTO> gemsDTOs = gemsList.stream()
                .map(GemsTransactionDTO::new)
                .toList();

        return ResponseEntity.ok().body(new TransactionResponseDTO(
                gemsDTOs,
                productsDTOs));
    }

    @GetMapping("/page")
    @TransactionDocSwagger.FindPageTransactionSwagger
    public ResponseEntity<TransactionResponseDTO> findPage(
            @RequestParam(value = "type", defaultValue = "all") String type,
            @RequestParam(value = "page", defaultValue = "0") Integer page,
            @RequestParam(value = "linesPerPage", defaultValue = "10") Integer linesPerPage,
            @RequestParam(value = "orderBy", defaultValue = "purchaseDate") String orderBy,
            @RequestParam(value = "direction", defaultValue = "ASC") String direction) {

        Page<ProductTransaction> productTransactionPage = null;
        Page<GemsTransaction> gemsTransactionPage = null;

        if ("all".equalsIgnoreCase(type) || "product".equalsIgnoreCase(type)) {
            productTransactionPage = service.productListTransactionPage(page, linesPerPage, orderBy, direction);
        }
        if ("all".equalsIgnoreCase(type) || "gems".equalsIgnoreCase(type)) {
            gemsTransactionPage = service.gemsListTransactionPage(page, linesPerPage, orderBy, direction);
        }

        List<ProductTransactionDTO> productDTOs = productTransactionPage != null
                ? productTransactionPage.getContent()
                                        .stream()
                                        .map(ProductTransactionDTO::new)
                                        .toList()
                : Collections.emptyList();

        List<GemsTransactionDTO> gemsDTOs = gemsTransactionPage != null
                ? gemsTransactionPage.getContent()
                                        .stream()
                                        .map(GemsTransactionDTO::new)
                                        .toList()
                : Collections.emptyList();

        return ResponseEntity.ok().body(new TransactionResponseDTO(
                gemsDTOs,
                productDTOs));
    }

}
