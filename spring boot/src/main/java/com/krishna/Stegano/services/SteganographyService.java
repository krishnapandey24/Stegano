package com.krishna.Stegano.services;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.*;

@Service
public class SteganographyService {
    public byte[] encodeImage(MultipartFile imageFile, String message) throws IOException {
        BufferedImage bufferedImage = getBufferedImage(imageFile);
        return hideMessage(message, bufferedImage);
    }

    public String decodeImage(MultipartFile imageFile) throws IOException {
        BufferedImage bufferedImage = getBufferedImage(imageFile);
        return decodeMessage(bufferedImage);
    }

    public BufferedImage getBufferedImage(MultipartFile imageFile) throws IOException {
        byte[] fileBytes = imageFile.getBytes();
        InputStream inputStream = new ByteArrayInputStream(fileBytes);
        return ImageIO.read(inputStream);
    }


    public byte[] hideMessage(String message, BufferedImage image) throws IOException {
        int messageLength = message.length();
        int[] bitLengthMessage = getBinaryArray(messageLength);

        int currentBitIndex = 0;
        int bitValue;
        for (int x = 0; x < image.getWidth(); x++) {
            for (int y = 0; y < image.getHeight(); y++) {
                if (x == 0 && y < 8) {
                    bitValue = bitLengthMessage[y];
                    currentBitIndex++;
                    getCurrentBitIndex(image, x, y, bitValue);
                } else if (currentBitIndex < messageLength * 8 + 8) {
                    int charIndex = (currentBitIndex - 8) / 8;
                    char character = message.charAt(charIndex);
                    int bitIndex = (currentBitIndex - 8) % 8;
                    bitValue = (character >> (7 - bitIndex)) & 1;
                    currentBitIndex++;
                    getCurrentBitIndex(image, x, y, bitValue);
                }
            }
        }

        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        ImageIO.write(image, "png", baos);
        baos.flush();
        byte[] byteArray = baos.toByteArray();
        baos.close();

        return byteArray;
    }
    private int[] getBinaryArray(int value) {
        int[] binaryArray = new int[8];
        StringBuilder binaryString = new StringBuilder(Integer.toBinaryString(value));

        while (binaryString.length() != 8) {
            binaryString.insert(0, '0');
        }

        for (int i = 0; i < 8; i++) {
            binaryArray[i] = Integer.parseInt(String.valueOf(binaryString.charAt(i)));
        }

        return binaryArray;
    }

    private void getCurrentBitIndex(BufferedImage image, int x, int y, int bitValue) {
        int currentPixel = image.getRGB(x, y);
        int red = (currentPixel >> 16) & 255;
        int green = (currentPixel >> 8) & 255;
        int blue = currentPixel & 255;

        int modifiedPixel = ((blue & 0xFE) | bitValue);

        modifiedPixel = (red << 16) | (green << 8) | modifiedPixel;
        image.setRGB(x, y, modifiedPixel);

    }


    public String decodeMessage(BufferedImage image) {
        int messageLength = 0;
        StringBuilder binaryLengthMsg = new StringBuilder();
        StringBuilder binaryMsg = new StringBuilder();
        int currentBitEntry = 0;

        for (int x = 0; x < image.getWidth(); x++) {
            for (int y = 0; y < image.getHeight(); y++) {
                if (x == 0 && y < 8) {
                    int currentPixel = image.getRGB(x, y);
                    int blue = currentPixel & 255;
                    binaryLengthMsg.append(blue & 1);
                    if (binaryLengthMsg.length() == 8) {
                        messageLength = Integer.parseInt(binaryLengthMsg.toString(), 2);
                    }
                } else if (currentBitEntry < messageLength * 8) {
                    int currentPixel = image.getRGB(x, y);
                    int blue = currentPixel & 255;
                    binaryMsg.append(blue & 1);
                    currentBitEntry++;
                }
            }
        }

        StringBuilder decodedMsg = new StringBuilder();
        for (int i = 0; i < binaryMsg.length(); i += 8) {
            String sub = binaryMsg.substring(i, i + 8);
            int decimalValue = Integer.parseInt(sub, 2);
            char character = (char) decimalValue;
            decodedMsg.append(character);
        }

        return decodedMsg.toString();
    }

}
