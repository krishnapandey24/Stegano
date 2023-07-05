package com.krishna.Stegano.payloads;

public class DecodeResponse {
    String originalString;
    byte[] fileContent;

    public DecodeResponse(String originalString, byte[] fileContent) {
        this.originalString = originalString;
        this.fileContent = fileContent;
    }

}