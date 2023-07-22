import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../model/decode_response.dart';


class API {
  late Dio dio;

  API() {
    BaseOptions baseOptions = BaseOptions(baseUrl: kDebugMode ? 'http://localhost:8080/api/' : 'https://steganoapp.azurewebsites.net/api/' );
    dio = Dio(baseOptions);
  }

  Future<String> login(String email, String password) async{
    try{
         Response response= await dio.post(
           '/user/login',
           data: {
             "email" : email,
             "password" : password
           }
         );

         return response.data;
    }catch(e){
      throw Exception(e);
    }
  }

  Future<String> register(String email, String password) async{
    try{
      Response response= await dio.post(
          '/user/register',
          data: {
            "email" : email,
            "password" : password
          }
      );

      return response.data;
    }catch(e){
      throw Exception(e);
    }
  }


  Future<DecodeResponse> decodeImage(Uint8List fileBytes, bool encryptMessage,[String? encryptionKey]) async {
    try {
      FormData formData = FormData.fromMap({
        'file': MultipartFile.fromBytes(fileBytes, filename: 'file.jpg'),
        'isEncrypted': encryptMessage,
        'encryptionKey': encryptionKey,
      });

      Response response = await dio.post(
        '/app/decodeImage',
        data: formData,
      );

      DecodeResponse decodeResponse = DecodeResponse.fromJson(response.data);
      return decodeResponse;
    } catch (e) {
      throw Exception('Failed to decode image');
    }
  }




  Future<Uint8List> encodeImageForWeb(Uint8List fileBytes, String message, bool encryptMessage,[String? encryptionKey]) async {
    try {
      FormData formData = FormData.fromMap({
        'message': message,
        'encryptMessage': encryptMessage,
        'file': MultipartFile.fromBytes(fileBytes, filename: 'file.jpg'),
        'encryptionKey': encryptionKey,
      });

      Response response = await dio.post(
        '/app/encodeImage',
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
