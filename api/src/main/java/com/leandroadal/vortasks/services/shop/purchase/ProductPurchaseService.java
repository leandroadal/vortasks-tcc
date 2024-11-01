package com.leandroadal.vortasks.services.shop.purchase;

import java.time.Instant;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.leandroadal.vortasks.entities.shop.product.Product;
import com.leandroadal.vortasks.entities.shop.transaction.ProductTransaction;
import com.leandroadal.vortasks.entities.user.User;
import com.leandroadal.vortasks.repositories.shop.ProductRepository;
import com.leandroadal.vortasks.security.UserSS;
import com.leandroadal.vortasks.services.shop.products.ProductService;
import com.leandroadal.vortasks.services.shop.purchase.exceptions.InsufficientFundsException;
import com.leandroadal.vortasks.services.user.UserService;

@Service
public class ProductPurchaseService {

    @Autowired
    private UserService userService;

    @Autowired
    private ProductService productService;

    @Autowired
    private ProductRepository productRepo;	

    @Autowired
    private TransactionService transactionService;

    @Autowired
    private LogPurchase log;

    @Transactional
    public ProductTransaction productPurchase(Long request) {
        UserSS userSS = UserService.authenticated();
        User user = getUserById(userSS.getId());
        Product product = getProductById(request);

        if (hasEnoughCoinsAndGems(user, product)) {
            updateUserDataAfterPurchase(user, product);
            return createProductTransaction(user, product);
        } else {
            log.NotEnoughCoinsAndGems(request);
            throw new InsufficientFundsException(request);
        }
    }

    private User getUserById(String userId) {
        return userService.findUserById(userId);
    }

    private Product getProductById(Long productId) {
        return productService.productById(productId);
    }

    private boolean hasEnoughCoinsAndGems(User user, Product product) {
        return user.getProgressData().getCoins() >= product.getCoins()
                && user.getProgressData().getGems() >= product.getGems();
    }

    private void updateUserDataAfterPurchase(User user, Product product) {
        user.getProgressData().setCoins(user.getProgressData().getCoins() - product.getCoins());
        user.getProgressData().setGems(user.getProgressData().getGems() - product.getGems());
        user.getPurchasedProducts().add(product);
        userService.save(user);
    }

    private ProductTransaction createProductTransaction(User user, Product product) {
        ProductTransaction transaction = new ProductTransaction();
        transaction.setUser(user);
        transaction.setProduct(product);
        transaction.setPurchaseDate(Instant.now());
        transaction.setPriceInCoins(product.getCoins());
        transaction.setPriceInGems(product.getGems());
        transactionService.saveProductTransaction(transaction);
        product.sell();
        productRepo.save(product);

        log.createProductTransaction(transaction.getId());
        return transaction;
    }
}
