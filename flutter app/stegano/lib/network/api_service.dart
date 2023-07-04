import 'dart:typed_data';

import 'package:dio/dio.dart';

class API {
  static final baseOptions= BaseOptions(baseUrl: 'localhost:8080/');
  static final Dio dio = Dio(baseOptions);

  Future<Uint8List> postImageWithMessage(String url, Uint8List imageFileBytes, String message) async {
    FormData formData = FormData.fromMap({
      'file': MultipartFile.fromBytes(imageFileBytes),
      'message': message,
    });


    try {
      Response response = await dio.post(url, data: formData);
      if (response.statusCode == 200) {
        return Uint8List.fromList(response.data);
      } else {
        throw Exception('Failed to send request: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }


}
