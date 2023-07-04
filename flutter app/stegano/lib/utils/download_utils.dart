import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';

class DownloadUtils{

  static void downloadFileForWeb(Uint8List uInt8list, String fileName){
    final content = base64Encode(uInt8list);
    AnchorElement(
        href: "data:application/octet-stream;charset=utf-16le;base64,$content")
      ..setAttribute("download", fileName)
      ..click();

  }

  static void downloadFileForMobile(Uint8List uInt8list, String extension){

  }

  static void downloadImageTextFileForWeb(Uint8List uint8list, String extension){
    final content = base64Encode(uint8list);
    AnchorElement(
        href: "data:application/octet-stream;charset=utf-16le;base64,$content")
      ..setAttribute("download", "encoded_image.$extension")
      ..click();
  }
}