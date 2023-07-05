package com.krishna.Stegano.payloads;

import org.springframework.web.multipart.MultipartFile;

public class DecodeDTO {
    private MultipartFile file;
    private boolean isEncrypted;
    private String encryptionKey;

    public DecodeDTO() {
    }

    public DecodeDTO(MultipartFile file, boolean encryptMessage, String encryptionKey) {
        this.file = file;
        this.isEncrypted = encryptMessage;
        this.encryptionKey = encryptionKey;
    }

    public MultipartFile getFile() {
        return file;
    }


    public boolean isEncrypted() {
        return isEncrypted;
    }


    public String getEncryptionKey() {
        return encryptionKey;
    }

}

