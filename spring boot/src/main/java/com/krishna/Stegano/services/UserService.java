package com.krishna.Stegano.services;

import com.krishna.Stegano.models.User;
import com.krishna.Stegano.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class UserService {

    private final UserRepository userRepository;

    BCryptPasswordEncoder bCryptPasswordEncoder;


    @Autowired
    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
        bCryptPasswordEncoder= new BCryptPasswordEncoder();
    }

    public void saveUser(User user){
        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
        userRepository.save(user);
    }

    public List<User> getAllUsers(){
        return userRepository.findAll();
    }

    public User getUserByEmail(String email){
        return userRepository.findByEmail(email);
    }

}