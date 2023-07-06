package com.krishna.Stegano.payloads;

import lombok.Data;


@Data
public class DecodeResponse {
    private String originalString;
    private byte[] fileContent;

    public DecodeResponse(String originalString, byte[] fileContent) {
        this.originalString = originalString;
        this.fileContent = fileContent;
    }

}
