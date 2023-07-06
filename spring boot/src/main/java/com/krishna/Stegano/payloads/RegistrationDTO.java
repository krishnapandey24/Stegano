package com.krishna.Stegano.payloads;

public class RegistrationDTO {
    String email;
    String password;

    public RegistrationDTO(String email, String password) {
        this.email = email;
        this.password = password;
    }


    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }
}
