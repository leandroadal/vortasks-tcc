package com.leandroadal.vortasks.services.auth;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Service;

import com.leandroadal.vortasks.entities.user.User;
import com.leandroadal.vortasks.security.UserSS;
import com.leandroadal.vortasks.services.exception.InvalidCredentialsException;
import com.leandroadal.vortasks.services.exception.ObjectNotFoundException;
import com.leandroadal.vortasks.services.user.UserService;

@Service
public class UserDetailsServiceImpl implements UserDetailsService {

    @Autowired
    private UserService service;

    @Override
    public UserDetails loadUserByUsername(String username) {
        return buildUserDetails(username);
    }

    private UserDetails buildUserDetails(String login) {
        try {
            if (!login.isEmpty()) {
                User user = service.findUserByUsernameOrEmail(login);

                return new UserSS(user.getId(), user.getUsername(), user.getPassword(), user.getRole());
            }
            return null;
        } catch (ObjectNotFoundException e) {
            throw new InvalidCredentialsException("O Username '" + login + "' não foi encontrado!");
        } 

    }

}
