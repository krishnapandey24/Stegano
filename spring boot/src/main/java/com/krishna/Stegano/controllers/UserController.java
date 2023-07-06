package com.krishna.Stegano.controllers;

import com.krishna.Stegano.models.User;
import com.krishna.Stegano.payloads.RegistrationDTO;
import com.krishna.Stegano.security.JwtUtils;
import com.krishna.Stegano.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api")
public class UserController {
    private final UserService service;
    private final JwtUtils jwtUtils;

    @Autowired
    public UserController(UserService service, JwtUtils jwtUtils) {
        this.service = service;
        this.jwtUtils = jwtUtils;
    }


    @GetMapping("/users")
    public List<User> getUsers() {
        return service.getAllUsers();
    }

    @PostMapping("/register")
    public ResponseEntity<String> addStudents(@RequestBody RegistrationDTO registrationDTO) {
        if (service.getUserByEmail(registrationDTO.getEmail())!=null) {
            return ResponseEntity.badRequest().body("Email is already taken!");
        }

        User user = new User();
        user.setEmail(registrationDTO.getEmail());
        user.setPassword(registrationDTO.getPassword());

        service.saveUser(user);
        String token = jwtUtils.generateToken(user);

        return ResponseEntity.ok(token);
    }


}
