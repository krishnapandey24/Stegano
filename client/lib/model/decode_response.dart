import 'dart:convert';
import 'dart:typed_data';

class DecodeResponse {
  final String data;
  final Uint8List byteData;

  DecodeResponse(this.data, this.byteData);

  factory DecodeResponse.fromJson(Map<String, dynamic> json) {
    String bytes= json["fileContent"];
    Uint8List imageData = base64Decode(bytes);
    return DecodeResponse(json['originalString'], imageData);
  }
}
