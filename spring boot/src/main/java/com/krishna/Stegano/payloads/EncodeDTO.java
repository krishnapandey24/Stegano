package com.krishna.Stegano.payloads;

import org.springframework.web.multipart.MultipartFile;

public class EncodeDTO {
    private MultipartFile file;
    private String message;
    private boolean encryptMessage;
    private String encryptionKey;

    public EncodeDTO() {
    }

    public EncodeDTO(MultipartFile file, String message, boolean encryptMessage, String encryptionKey) {
        this.file = file;
        this.message = message;
        this.encryptMessage = encryptMessage;
        this.encryptionKey = encryptionKey;
    }

    public MultipartFile getFile() {
        return file;
    }

    public String getMessage() {
        return message;
    }


    public boolean encryptMessage() {
        return encryptMessage;
    }


    public String getEncryptionKey() {
        return encryptionKey;
    }

}

