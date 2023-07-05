package com.krishna.Stegano.controllers;

import com.krishna.Stegano.payloads.DecodeDTO;
import com.krishna.Stegano.payloads.DecodeResponse;
import com.krishna.Stegano.payloads.EncodeDTO;
import com.krishna.Stegano.services.EncryptionService;
import com.krishna.Stegano.services.SteganographyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import java.nio.charset.StandardCharsets;

@Controller
@RequestMapping("/api/app")
public class SteganographyController {
    private final SteganographyService steganographyService;
    private final EncryptionService encryptionService;


    @Autowired
    public SteganographyController(SteganographyService steganographyService, EncryptionService encryptionService) {
        this.steganographyService = steganographyService;
        this.encryptionService = encryptionService;
    }

    @PostMapping(value = "/encodeImage", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<byte[]> encodeImage(@RequestBody EncodeDTO encodeDTO) {
        try{
            String message= encodeDTO.encryptMessage() ? encryptionService.encrypt(encodeDTO.getMessage(),encodeDTO.getEncryptionKey()) : encodeDTO.getMessage();
            return ResponseEntity.ok(steganographyService.encodeImage(encodeDTO.getFile(),message));
        }catch (Exception e){
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @PostMapping(value = "/decodeImage", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<DecodeResponse> decodeImage(@RequestBody DecodeDTO decodeDTO) {
        try{
            String data= steganographyService.decodeImage(decodeDTO.getFile());
            if(decodeDTO.isEncrypted()) data= encryptionService.decrypt(data, decodeDTO.getEncryptionKey());
            return ResponseEntity.ok(new DecodeResponse(data,data.getBytes(StandardCharsets.UTF_8)));
        }catch (Exception e){
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

}
