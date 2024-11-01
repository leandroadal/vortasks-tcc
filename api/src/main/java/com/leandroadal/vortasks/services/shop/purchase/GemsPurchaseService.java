package com.leandroadal.vortasks.services.shop.purchase;

import java.math.BigDecimal;
import java.time.Instant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.leandroadal.vortasks.entities.shop.dto.CompletePurchaseRequestDTO;
import com.leandroadal.vortasks.entities.shop.enumerators.PaymentStatus;
import com.leandroadal.vortasks.entities.shop.product.GemsPackage;
import com.leandroadal.vortasks.entities.shop.transaction.GemsTransaction;
import com.leandroadal.vortasks.entities.user.User;
import com.leandroadal.vortasks.repositories.shop.GemsPackageRepository;
import com.leandroadal.vortasks.security.UserSS;
import com.leandroadal.vortasks.services.exception.ValidateException;
import com.leandroadal.vortasks.services.shop.payments.PaymentResult;
import com.leandroadal.vortasks.services.shop.payments.PaymentService;
import com.leandroadal.vortasks.services.shop.payments.exceptions.PaymentException;
import com.leandroadal.vortasks.services.shop.payments.exceptions.PaymentMismatchException;
import com.leandroadal.vortasks.services.shop.products.GemsPackageService;
import com.leandroadal.vortasks.services.shop.purchase.exceptions.TransactionFinishException;
import com.leandroadal.vortasks.services.user.UserService;

@Service
public class GemsPurchaseService {

    @Autowired
    private UserService userService;

    @Autowired
    private GemsPackageService gemsPackageService;

    @Autowired
    private GemsPackageRepository gemsRepo;

    @Autowired
    private TransactionService transactionService;

    @Autowired
    private PaymentService paymentService;

    @Autowired
    private LogPurchase log;


    public GemsTransaction startGemsPurchase(Long gemsPackageId) {
        UserSS userSS = UserService.authenticated();
        User user = getUserById(userSS.getId());
        GemsPackage gemsPackage = getGemsPackageById(gemsPackageId);
        return createGemsTransaction(user, gemsPackage);
    }

    private User getUserById(String userId) {
        return userService.findUserById(userId);
    }

    private GemsPackage getGemsPackageById(Long gemsPackageId) {
        return gemsPackageService.getGemsPackageById(gemsPackageId);
    }

    private GemsTransaction createGemsTransaction(User user, GemsPackage gemsPackage) {
        GemsTransaction transaction = new GemsTransaction();
        transaction.setUser(user);
        transaction.setGemsPackage(gemsPackage);
        transaction.setPurchaseDate(Instant.now());
        transaction.setStatus(PaymentStatus.PENDING);
        transaction.setPrice(gemsPackage.priceWithDiscount());
        saveTransaction(transaction);
        log.createGemsTransaction(transaction.getId());
        return transaction;
    }

    public void cancelGemsPurchase(String transactionId) {
        GemsTransaction gemsTransaction = getGemsTransactionById(transactionId);
        validateUserAuth(gemsTransaction.getUser().getId());

        gemsTransaction.setStatus(PaymentStatus.CANCELLED);
        saveTransaction(gemsTransaction);
        log.cancelGemsTransaction(transactionId);
    }

    private GemsTransaction getGemsTransactionById(String gemsTransactionId) {
        return transactionService.getGemsTransactionById(gemsTransactionId);
    }

    private void validateUserAuth(String userId) {
        UserSS userSS = UserService.authenticated();
        if (!userSS.getId().equals(userId)) {
            throw new ValidateException("Requisição invalida para o usuário");
        }
    }

    public void completeGemsPurchase(CompletePurchaseRequestDTO request) {
        UserSS userSS = UserService.authenticated();
        User user = getUserById(userSS.getId());
        GemsTransaction transaction = getGemsTransactionById(request.gemsTransactionId());

        validateTransactionStatus(transaction);
        try {
            processGemsTransaction(user, transaction, request.paymentToken());
        } catch (PaymentMismatchException e) {
            handleDeclinedPayment(transaction, e.getMessage());
            log.declinedGemsTransaction(transaction.getId());
            throw e;
        } catch (PaymentException e) {
            handlePaymentException(transaction, e.getMessage());
            log.errorGemsTransaction(transaction.getId());
            throw e;   
        } 
    }

    private void validateTransactionStatus(GemsTransaction transaction) {
        if ((transaction.getStatus() == PaymentStatus.APPROVED) && (transaction.getStatus() == PaymentStatus.CANCELLED)) {
            throw new TransactionFinishException(transaction.getId());
        }
    }

    private void processGemsTransaction(User user, GemsTransaction transaction, BigDecimal paymentToken) {
        PaymentResult paymentResult = paymentService.processPayment(paymentToken, transaction.getPrice());

        if (paymentResult.isSuccess()) {
            transaction.setStatus(PaymentStatus.APPROVED);
            transaction.setErrorMessage("");
            saveTransaction(transaction);

            GemsPackage gemsPackage = transaction.getGemsPackage();
            updateUserGems(user, gemsPackage);
            gemsPackage.sell();
            gemsRepo.save(gemsPackage);
        } 
    }

    private void updateUserGems(User user, GemsPackage gemsPackage) {
        int gems = user.getProgressData().getGems();
        user.getProgressData().setGems(gems + gemsPackage.getGems());
        userService.save(user);
    }

    private void handleDeclinedPayment(GemsTransaction transaction, String errorMessage) {
        transaction.setStatus(PaymentStatus.DECLINED);
        transaction.setErrorMessage(errorMessage);
        saveTransaction(transaction);
    }

    private void handlePaymentException(GemsTransaction transaction, String errorMessage) {
        transaction.setStatus(PaymentStatus.ERROR);
        transaction.setErrorMessage(errorMessage);
        saveTransaction(transaction);
    }

    private void saveTransaction(GemsTransaction transaction){
        transactionService.saveGemsTransaction(transaction);
    }
}


