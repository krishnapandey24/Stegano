package com.krishna.Stegano.controllers;

import com.krishna.Stegano.payloads.DecodeResponse;
import com.krishna.Stegano.payloads.EncodeResponse;
import com.krishna.Stegano.services.EncryptionService;
import com.krishna.Stegano.services.SteganographyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import java.nio.charset.StandardCharsets;


@RestController
@RequestMapping("/api/app")
public class SteganographyController {
    private final SteganographyService steganographyService;
    private final EncryptionService encryptionService;


    @Autowired
    public SteganographyController(SteganographyService steganographyService, EncryptionService encryptionService) {
        this.steganographyService = steganographyService;
        this.encryptionService = encryptionService;
    }

    @GetMapping("/test")
    public String test() {
        return "<b>Hello</b>";
    }


    @PostMapping(value = "/encodeImage")
    public ResponseEntity<EncodeResponse> encodeImage(@RequestParam("file") MultipartFile file,
                                                      @RequestParam("message") String message,
                                                      @RequestParam("encryptMessage") boolean encryptMessage,
                                                      @RequestParam(value = "encryptionKey", required = false) String encryptionKey
    ) {

        try {
            message = encryptMessage ? encryptionService.encrypt(message, encryptionKey) : message;
            byte[] fileBytes = steganographyService.encodeImage(file, message);
            EncodeResponse encodeResponse = new EncodeResponse();
            encodeResponse.setFileBytes(fileBytes);
            return ResponseEntity.ok(encodeResponse);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @PostMapping(value = "/decodeImage")
    public ResponseEntity<DecodeResponse> decodeImage(
            @RequestParam("file") MultipartFile file,
            @RequestParam("isEncrypted") boolean isEncrypted,
            @RequestParam(value = "encryptionKey", required = false) String encryptionKey
    ) {
        try {
            String data = steganographyService.decodeImage(file);
            if (isEncrypted) data = encryptionService.decrypt(data, encryptionKey);
            return ResponseEntity.ok(new DecodeResponse(data, data.getBytes(StandardCharsets.UTF_8)));
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

}
