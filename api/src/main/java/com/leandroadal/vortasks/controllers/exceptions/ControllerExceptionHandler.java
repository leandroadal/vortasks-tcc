package com.leandroadal.vortasks.controllers.exceptions;

import java.time.Instant;

import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import com.leandroadal.vortasks.services.backup.exceptions.BackupCreationException;
import com.leandroadal.vortasks.services.backup.exceptions.ObjectNotModifiedException;
import com.leandroadal.vortasks.services.exception.DatabaseException;
import com.leandroadal.vortasks.services.exception.ForbiddenAccessException;
import com.leandroadal.vortasks.services.exception.InvalidCredentialsException;
import com.leandroadal.vortasks.services.exception.ObjectNotFoundException;
import com.leandroadal.vortasks.services.exception.ValidateException;
import com.leandroadal.vortasks.services.shop.payments.exceptions.PaymentException;
import com.leandroadal.vortasks.services.shop.payments.exceptions.PaymentMismatchException;
import com.leandroadal.vortasks.services.shop.purchase.exceptions.InsufficientFundsException;
import com.leandroadal.vortasks.services.shop.purchase.exceptions.TransactionFinishException;
import com.leandroadal.vortasks.services.social.friendship.exceptions.FriendException;

import jakarta.servlet.http.HttpServletRequest;

@ControllerAdvice
public class ControllerExceptionHandler {

    @ExceptionHandler(ObjectNotFoundException.class)
    public ResponseEntity<StandardError> objectNotFound(ObjectNotFoundException e, HttpServletRequest request) {
        String error = "Objeto não encontrado";
        HttpStatus status = HttpStatus.NOT_FOUND;
        String message = e.getMessage();
        StandardError err = new StandardError(Instant.now(), status.value(), error, message, request.getRequestURI());
        return ResponseEntity.status(status).body(err);
    }

    // ----------------------- SECURITY -----------------------

    @ExceptionHandler(InvalidCredentialsException.class)
    public ResponseEntity<StandardError> invalidCredentials(InvalidCredentialsException e, HttpServletRequest request) {
        String error = "Credenciais invalidas";
        HttpStatus status = HttpStatus.UNAUTHORIZED;
        StandardError err = new StandardError(Instant.now(), status.value(), error, e.getMessage(), request.getRequestURI());
        return ResponseEntity.status(status).body(err);
    }

    @ExceptionHandler(ForbiddenAccessException.class)
    public ResponseEntity<StandardError> forbiddenAccess(ForbiddenAccessException e, HttpServletRequest request) {
        String error = "Acesso negado";
        HttpStatus status = HttpStatus.FORBIDDEN;
        StandardError err = new StandardError(Instant.now(), status.value(), error, e.getMessage(), request.getRequestURI());
        return ResponseEntity.status(status).body(err);
    }

    // ----------------------- Validation -----------------------

    @ExceptionHandler(ValidateException.class)
    public ResponseEntity<StandardError> validate(ValidateException e, HttpServletRequest request) {
        String error = "Erro ao validar";
        HttpStatus status = HttpStatus.BAD_REQUEST;
        StandardError err = new StandardError(Instant.now(), status.value(), error, e.getMessage(), request.getRequestURI());
        return ResponseEntity.status(status).body(err);
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<StandardError> validation(MethodArgumentNotValidException e, HttpServletRequest request) {
        String error = "Erro ao validar o argumento";
        HttpStatus status = HttpStatus.BAD_REQUEST;
        ValidationError err = new ValidationError(Instant.now(), status.value(), error, e.getMessage(), request.getRequestURI());
        for (FieldError fieldError : e.getBindingResult().getFieldErrors()) {
			err.addError(fieldError.getField(), fieldError.getDefaultMessage());
		}
        return ResponseEntity.status(status).body(err);
    }

    // ----------------------- BACKUP -----------------------

    @ExceptionHandler(BackupCreationException.class)
    public ResponseEntity<StandardError> backupCreate(BackupCreationException e, HttpServletRequest request) {
        String error = "Erro no backup";
        HttpStatus status = HttpStatus.BAD_REQUEST;
        StandardError err = new StandardError(Instant.now(), status.value(), error, e.getMessage(), request.getRequestURI());
        return ResponseEntity.status(status).body(err);
    }

    @ExceptionHandler(ObjectNotModifiedException.class)
    public ResponseEntity<StandardError> notModified(ObjectNotModifiedException e, HttpServletRequest request) {
        String error = "Nao ha dados mais recentes";
        HttpStatus status = HttpStatus.NOT_MODIFIED;
        StandardError err = new StandardError(Instant.now(), status.value(), error, e.getMessage(), request.getRequestURI());
        return ResponseEntity.status(status).body(err);
    }

    // ----------------------- FRIENDSHIP -----------------------
    
    @ExceptionHandler(FriendException.class)
    public ResponseEntity<StandardError> friendReceiverMismatch(FriendException e, HttpServletRequest request) {
        String error = "Erro ao recuperar amigo";
        HttpStatus status = HttpStatus.BAD_REQUEST;
        StandardError err = new StandardError(Instant.now(), status.value(), error, e.getMessage(), request.getRequestURI());
        return ResponseEntity.status(status).body(err);
    }

    // ----------------------- DATABASE -----------------------

    @ExceptionHandler(DatabaseException.class)
    public ResponseEntity<StandardError> databaseException(DatabaseException e, HttpServletRequest request) {
        String error = "Erro no banco de dados";
        HttpStatus status = HttpStatus.BAD_REQUEST;
        StandardError err = new StandardError(Instant.now(), status.value(), error, e.getMessage(), request.getRequestURI());
        return ResponseEntity.status(status).body(err);
    }

    @ExceptionHandler(DataIntegrityViolationException.class)
    public ResponseEntity<StandardError> integrityViolation(DataIntegrityViolationException e, HttpServletRequest request) {
        String error = "Erro no banco de dados";
        HttpStatus status = HttpStatus.BAD_REQUEST;
        StandardError err = new StandardError(Instant.now(), status.value(), error, e.getMessage(), request.getRequestURI());
        return ResponseEntity.status(status).body(err);
    }

    // ----------------------- SHOPPING -----------------------

    @ExceptionHandler(PaymentMismatchException.class)
    public ResponseEntity<StandardError> paymentMismatch(PaymentMismatchException e, HttpServletRequest request) {
        String error = "Erro no pagamento";
        HttpStatus status = HttpStatus.BAD_REQUEST;
        StandardError err = new StandardError(Instant.now(), status.value(), error, e.getMessage(), request.getRequestURI());
        return ResponseEntity.status(status).body(err);
    }

    @ExceptionHandler(PaymentException.class)
    public ResponseEntity<StandardError> payment(PaymentException e, HttpServletRequest request) {
        String error = "Erro no pagamento";
        HttpStatus status = HttpStatus.BAD_REQUEST;
        StandardError err = new StandardError(Instant.now(), status.value(), error, e.getMessage(), request.getRequestURI());
        return ResponseEntity.status(status).body(err);
    }

    @ExceptionHandler(TransactionFinishException.class)
    public ResponseEntity<StandardError> transactionFinish(TransactionFinishException e, HttpServletRequest request) {
        String error = "Erro na transação";
        HttpStatus status = HttpStatus.BAD_REQUEST;
        StandardError err = new StandardError(Instant.now(), status.value(), error, e.getMessage(), request.getRequestURI());
        return ResponseEntity.status(status).body(err);
    }

    @ExceptionHandler(InsufficientFundsException.class)
    public ResponseEntity<StandardError> insufficientFunds(InsufficientFundsException e, HttpServletRequest request) {
        String error = "Saldo insuficiente";
        HttpStatus status = HttpStatus.BAD_REQUEST;
        StandardError err = new StandardError(Instant.now(), status.value(), error, e.getMessage(), request.getRequestURI());
        return ResponseEntity.status(status).body(err);
    }

}
