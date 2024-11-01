package com.leandroadal.vortasks.services.auth;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.leandroadal.vortasks.entities.user.ProgressData;
import com.leandroadal.vortasks.entities.user.User;
import com.leandroadal.vortasks.entities.user.UserRole;
import com.leandroadal.vortasks.security.JWTService;
import com.leandroadal.vortasks.security.TokenCache;
import com.leandroadal.vortasks.security.UserSS;
import com.leandroadal.vortasks.services.exception.InvalidCredentialsException;
import com.leandroadal.vortasks.services.exception.ValidateException;
import com.leandroadal.vortasks.services.user.UserService;

@Service
public class AuthService {

    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private JWTService tokenService;

    @Autowired
    private UserService service;

    @Autowired
    private LogAuth log;

    @Autowired
    private TokenCache tokenCache;
   
    public String login(String login, String password){
        try {
            var usernamePassword = new UsernamePasswordAuthenticationToken(login, password);
            var auth = authenticationManager.authenticate(usernamePassword);
            String token = tokenService.generateToken((UserSS) auth.getPrincipal());
            log.login(login);
            return token;
        } catch (BadCredentialsException e) {
            throw new InvalidCredentialsException("Senha incorreta");
        }
        
    }

    public void logout(String token){
        token = token.replace("Bearer ", "");
        tokenCache.revokeToken(token);
        log.logout(token);
    }

    public User register(User data) {
        validateUsernameAndEmail(data);

        String encryptedPassword = new BCryptPasswordEncoder().encode(data.getPassword());
        data.setPassword(encryptedPassword);
        data.setRole(UserRole.USER);
        ProgressData newProgressData = new ProgressData(null, 0, 0, 1, 0.0f, null, data);
        data.setProgressData(newProgressData);
        service.save(data);

        log.register(data.getId());
        return data;
    }
    
    private void validateUsernameAndEmail(User data) {
        if(service.existsByUsername(data.getUsername())) {
            log.usernameAlreadyExists(data.getUsername());
            throw new ValidateException("O username '" + data.getUsername() + "' já existe!");
        }
        if (service.existsByEmail(data.getEmail())) {
            log.emailAlreadyExists(data.getEmail());
            throw new ValidateException("O email '" + data.getEmail() + "' já existe!");
        }
    }

    public User createAdmin(User data) {
        validateUsernameAndEmail(data);

        String encryptedPassword = new BCryptPasswordEncoder().encode(data.getPassword());
        data.setPassword(encryptedPassword);
        data.setRole(UserRole.ADMIN);
        ProgressData newProgressData = new ProgressData(null, 0, 0, 1, 0.0f, null, data);
        data.setProgressData(newProgressData);
        service.save(data);

        log.register(data.getId());
        return data;
    }
}
