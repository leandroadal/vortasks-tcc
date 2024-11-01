package com.leandroadal.vortasks.controllers.shop.purchase;

import java.net.URI;

import org.hibernate.validator.constraints.UUID;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.leandroadal.vortasks.controllers.shop.purchase.doc.PurchaseDocSwagger;
import com.leandroadal.vortasks.entities.shop.dto.CompletePurchaseRequestDTO;
import com.leandroadal.vortasks.entities.shop.dto.GemsTransactionDTO;
import com.leandroadal.vortasks.entities.shop.dto.ProductTransactionDTO;
import com.leandroadal.vortasks.entities.shop.dto.StartPurchaseRequestDTO;
import com.leandroadal.vortasks.entities.shop.transaction.GemsTransaction;
import com.leandroadal.vortasks.entities.shop.transaction.ProductTransaction;
import com.leandroadal.vortasks.services.shop.purchase.GemsPurchaseService;
import com.leandroadal.vortasks.services.shop.purchase.ProductPurchaseService;

import jakarta.validation.Valid;

@RestController
@RequestMapping("/shop/purchases")
public class PurchaseController {

    @Autowired
    private GemsPurchaseService gemsService;

    @Autowired
    private ProductPurchaseService productService;

    @PostMapping("/gems/start")
    @PurchaseDocSwagger.StartGemsPurchaseSwagger
    public ResponseEntity<GemsTransactionDTO> startGemsPurchase(@Valid @RequestBody StartPurchaseRequestDTO request) {
        GemsTransaction gemsT = gemsService.startGemsPurchase(request.productOrGemsId());
        URI uri = ServletUriComponentsBuilder.fromCurrentRequest()
                .replacePath("/shop/my-transactions/gems/{id}")
                .buildAndExpand(gemsT.getId())
                .toUri();
        return ResponseEntity.created(uri).body(new GemsTransactionDTO(gemsT));    
    }

    @PostMapping("/gems/complete")
    @PurchaseDocSwagger.CompleteGemsPurchaseSwagger
    public ResponseEntity<String> completeGemsPurchase(@Valid @RequestBody CompletePurchaseRequestDTO request) {
        gemsService.completeGemsPurchase(request);
        return ResponseEntity.ok("Compra concluída com sucesso.");
    }

    @PatchMapping("/gems/cancel/{transactionId}")
    @PurchaseDocSwagger.CancelGemsPurchaseSwagger
    public ResponseEntity<String> cancelGemsPurchase(@PathVariable @UUID  String transactionId) {
        gemsService.cancelGemsPurchase(transactionId);
        return ResponseEntity.ok("Compra cancelada com sucesso.");
    }

    @PostMapping("/product/{userId}")
    @PurchaseDocSwagger.ProductPurchaseSwagger
    public ResponseEntity<ProductTransactionDTO> productPurchase(@Valid @RequestBody StartPurchaseRequestDTO request) {
        ProductTransaction productT = productService.productPurchase(request.productOrGemsId());
        URI uri = ServletUriComponentsBuilder.fromCurrentRequest()
                .replacePath("/shop/my-transactions/product/{id}")
                .buildAndExpand(productT.getId())
                .toUri();
        return ResponseEntity.created(uri).body(new ProductTransactionDTO(productT));
    }
}
