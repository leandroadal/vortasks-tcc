package com.leandroadal.vortasks.services.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import com.leandroadal.vortasks.entities.user.User;
import com.leandroadal.vortasks.repositories.user.UserRepository;
import com.leandroadal.vortasks.security.UserSS;
import com.leandroadal.vortasks.services.exception.ObjectNotFoundException;

@Service
public class UserService {

    @Autowired
    private UserRepository repository;

    @Autowired
    private LogUser log;

    public User findMyUser() {
        UserSS userSS = authenticated();
        return findUserById(userSS.getId());
    }
    
    public User findUserById(String id) {
        try {
            return repository.findById(id).orElseThrow(() -> new ObjectNotFoundException(id));
        } catch (ObjectNotFoundException e) {
            log.userNotFound(id);
            throw e;
        }        
    }

    public String findUsernameByUserId(String id) {
        return findUserById(id).getUsername();   
    }

    public User findUserByUsername(String username) {
        try {
            return repository.findByUsername(username).orElseThrow(() -> new ObjectNotFoundException(username));
        } catch (ObjectNotFoundException e) {
            log.userByUsername(username);
            throw e;
        }   
    }

    public User findUserByUsernameOrEmail(String usernameOrEmail) {
        try {
            return repository.findByUsernameOrEmail(usernameOrEmail, usernameOrEmail);
        } catch (Exception e) {
            log.userByUsernameOrEmail(usernameOrEmail);
            throw e;
        }   
    }

    public boolean existsByUsername(String username) {
        return repository.existsByUsername(username);
    }

    public boolean existsByEmail(String email) {
        return repository.existsByEmail(email);
    }

    public static UserSS authenticated() {
		try {
			return (UserSS) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		}
		catch (Exception e) {
			return null;
		}
    }
    
    public User save(User user) {
        return repository.save(user);
    }
    
    public void delete(User user) {
        repository.delete(user);
    }
}

