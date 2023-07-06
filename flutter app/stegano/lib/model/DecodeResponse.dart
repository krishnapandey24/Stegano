import 'dart:typed_data';

class DecodeResponse {
  final String data;
  final Uint8List byteData;

  DecodeResponse(this.data, this.byteData);

  factory DecodeResponse.fromJson(Map<String, dynamic> json) {
    return DecodeResponse(json['data'], json['byteData'].cast<int>());
  }
}
