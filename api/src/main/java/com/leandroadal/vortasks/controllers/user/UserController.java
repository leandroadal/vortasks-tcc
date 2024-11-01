package com.leandroadal.vortasks.controllers.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.leandroadal.vortasks.controllers.user.doc.UserSwagger;
import com.leandroadal.vortasks.entities.user.dto.UserResponseDTO;
import com.leandroadal.vortasks.services.user.UserService;

@RestController
@RequestMapping(value = "/user")
public class UserController {
    
    @Autowired
    private UserService service;

    @GetMapping
    @UserSwagger.GetMyUserSwagger
    public ResponseEntity<UserResponseDTO> findMyUser() {
        return ResponseEntity.ok(new UserResponseDTO(service.findMyUser()));
    }

    @GetMapping("/{userId}")
    @UserSwagger.GetUsernameByIdSwagger
    public ResponseEntity<String> getUsernameById(@PathVariable String userId) {
        String username = service.findUsernameByUserId(userId);
        return ResponseEntity.ok(username);
    }

}
