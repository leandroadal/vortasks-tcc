package com.leandroadal.vortasks.services.shop.purchase;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;

import com.leandroadal.vortasks.entities.shop.transaction.GemsTransaction;
import com.leandroadal.vortasks.entities.shop.transaction.ProductTransaction;
import com.leandroadal.vortasks.repositories.shop.GemsTransactionRepository;
import com.leandroadal.vortasks.repositories.shop.ProductTransactionRepository;
import com.leandroadal.vortasks.security.UserSS;
import com.leandroadal.vortasks.services.exception.ForbiddenAccessException;
import com.leandroadal.vortasks.services.exception.ObjectNotFoundException;
import com.leandroadal.vortasks.services.user.UserService;

@Service
public class TransactionService {
    
    @Autowired
    private GemsTransactionRepository gemsRepository;

    @Autowired
    private ProductTransactionRepository productRepository;

    @Autowired
    private LogPurchase log;

    public List<ProductTransaction> myProductListTransaction() {
        UserSS userSS = UserService.authenticated();
        return productRepository.findAllByUserId(userSS.getId());
    }

    public List<GemsTransaction> myGemsListTransaction() {
        UserSS userSS = UserService.authenticated();
        return gemsRepository.findAllByUserId(userSS.getId());
    }

    public GemsTransaction findGemsTransaction(String id) {
        GemsTransaction gems = getGemsTransactionById(id);
        validateUserAuth(gems.getUser().getId());
        return gems;
    }

    public GemsTransaction getGemsTransactionById(String id) {
        try {
            return gemsRepository.findById(id).orElseThrow(() -> new ObjectNotFoundException(id));
        } catch (ObjectNotFoundException e) {
            log.gemsTransactionNotFound(id);
            throw e;
        }
    }

    private void validateUserAuth(String userId) {
        UserSS userSS = UserService.authenticated();
        if (!userSS.getId().equals(userId)) {
            throw new ForbiddenAccessException("Requisição invalida para o usuário");
        }
    }

    public ProductTransaction findProductTransaction(String id) {
        ProductTransaction product = getProductTransactionById(id);
        validateUserAuth(product.getUser().getId());
        return product;
    }

    public ProductTransaction getProductTransactionById(String id) {
        try {
           return productRepository.findById(id).orElseThrow(() -> new ObjectNotFoundException(id)); 
        } catch (ObjectNotFoundException e) {
            log.productTransactionNotFound(id);
            throw e;
        }
    }

    protected void saveProductTransaction(ProductTransaction transaction) {
        productRepository.save(transaction);
    }

    protected void saveGemsTransaction(GemsTransaction transaction) {
        gemsRepository.save(transaction);
    }

    public Page<ProductTransaction> productListTransactionPage(Integer page, Integer linesPerPage, String orderBy,
            String direction) {
        PageRequest pageRequest = PageRequest.of(page, linesPerPage, Direction.valueOf(direction), orderBy);
        return productRepository.findAll(pageRequest);
    }

    public Page<GemsTransaction> gemsListTransactionPage(Integer page, Integer linesPerPage, String orderBy,
            String direction) {
        PageRequest pageRequest = PageRequest.of(page, linesPerPage, Direction.valueOf(direction), orderBy);
        return gemsRepository.findAll(pageRequest);
    }

}
