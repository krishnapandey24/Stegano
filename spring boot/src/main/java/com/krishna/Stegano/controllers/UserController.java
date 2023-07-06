package com.krishna.Stegano.controllers;

import com.krishna.Stegano.models.User;
import com.krishna.Stegano.payloads.LoginDTO;
import com.krishna.Stegano.payloads.RegistrationDTO;
import com.krishna.Stegano.security.JwtUtils;
import com.krishna.Stegano.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.*;


@RestController
@RequestMapping("/api/user")
public class UserController {
    private final UserService service;
    private final JwtUtils jwtUtils;

    private final BCryptPasswordEncoder bCryptPasswordEncoder;


    @Autowired
    public UserController(UserService service, JwtUtils jwtUtils) {
        this.service = service;
        this.jwtUtils = jwtUtils;
        bCryptPasswordEncoder= new BCryptPasswordEncoder();
    }


    @PostMapping("/register")
    public ResponseEntity<String> register(@RequestBody RegistrationDTO registrationDTO) {
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

    @PostMapping("/login")
    public ResponseEntity<String> login(@RequestBody LoginDTO loginDTO) {
        User user = service.getUserByEmail(loginDTO.getEmail());

        if (user == null) {
            return ResponseEntity.badRequest().body("Invalid email or password!");
        }


        if (!bCryptPasswordEncoder.matches(loginDTO.getPassword(),user.getPassword())) {
            return ResponseEntity.badRequest().body("Invalid email or password!");
        }

        String token = jwtUtils.generateToken(user);

        return ResponseEntity.ok(token);
    }


}
