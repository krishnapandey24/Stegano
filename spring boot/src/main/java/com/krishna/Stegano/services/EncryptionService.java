package com.krishna.Stegano.services;

import org.springframework.stereotype.Service;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.util.Arrays;
import java.util.Base64;

@Service
public class EncryptionService {
    private static final String ALGORITHM = "AES";
    private static final String ENCODING = StandardCharsets.UTF_8.name();

    public String encrypt(String plaintext, String key) throws Exception {
        SecretKeySpec secretKeySpec = generateSecretKeySpec(key);
        Cipher cipher = Cipher.getInstance(ALGORITHM);
        cipher.init(Cipher.ENCRYPT_MODE, secretKeySpec);

        byte[] encryptedBytes = cipher.doFinal(plaintext.getBytes(ENCODING));
        return Base64.getEncoder().encodeToString(encryptedBytes);
    }

    public String decrypt(String ciphertext, String key) throws Exception {
        SecretKeySpec secretKeySpec = generateSecretKeySpec(key);
        Cipher cipher = Cipher.getInstance(ALGORITHM);
        cipher.init(Cipher.DECRYPT_MODE, secretKeySpec);

        byte[] decodedBytes = Base64.getDecoder().decode(ciphertext);
        byte[] decryptedBytes = cipher.doFinal(decodedBytes);
        return new String(decryptedBytes, ENCODING);
    }

    private SecretKeySpec generateSecretKeySpec(String key) throws Exception {
        byte[] keyBytes = key.getBytes(ENCODING);
        MessageDigest sha = MessageDigest.getInstance("SHA-256");
        keyBytes = sha.digest(keyBytes);
        keyBytes = Arrays.copyOf(keyBytes, 16);

        return new SecretKeySpec(keyBytes, ALGORITHM);
    }
}

