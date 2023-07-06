import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import "package:universal_html/html.dart" as html;

import 'package:dio/dio.dart';

import '../model/DecodeResponse.dart';


class API {
  late Dio dio;

  API() {
    BaseOptions baseOptions = BaseOptions(baseUrl: 'http://localhost:8080/');
    dio = Dio(baseOptions);
  }



  Future<Uint8List> encodeImageForWeb2(html.File file, String message, bool encryptMessage, [String? encryptionKey]) async {
    try {
      String encryptMessageParam = encryptMessage.toString();
      FormData formData = FormData.fromMap({
        'file' : file,
        'message': message,
        'encryptMessage': encryptMessageParam,
        'encryptionKey': encryptionKey,
      });


      Response<Uint8List> response = await dio.post<Uint8List>(
        '/encodeImage',
        data: formData,
        options: Options(responseType: ResponseType.bytes),
      );
      if(response.data==null) throw Exception('null');
      return response.data!;
    } catch (s,e) {
      print(e);
      print(s);
      throw Exception('Failed to encode image');
    }
  }

  Future<DecodeResponse> decodeImage(File file, bool isEncrypted, [String? encryptionKey]) async {
    try {
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(file.path),
        'isEncrypted': isEncrypted.toString(),
        'encryptionKey': encryptionKey,
      });

      Response response = await dio.post(
        '/decodeImage',
        data: formData,
      );

      DecodeResponse decodeResponse = DecodeResponse.fromJson(response.data);
      return decodeResponse;
    } catch (e) {
      print(e);
      throw Exception('Failed to decode image');
    }
  }




  Future<Uint8List> encodeImageForWeb(Uint8List fileBytes, String message, bool encryptMessage) async {
    try {
      FormData formData = FormData.fromMap({
        'message': message,
        'encryptMessage': false,
        'file': MultipartFile.fromBytes(fileBytes, filename: 'file.jpg'),
      });

      Response response = await dio.post(
        '/encodeImage',
        data: formData,
      );

      String bytes= response.data["fileBytes"];
      Uint8List imageData = base64Decode(bytes);
      return imageData;
    } catch (error) {
      throw Exception(error);
    }
  }






}
