import "package:universal_html/html.dart" as html;
import 'dart:typed_data';

class FileGenerator{

  static html.File createFileFromUInt8List(Uint8List bytes) {
    final blob = html.Blob([bytes]);
    final file = html.File([blob], 'temp_file.jpg');
    return file;
  }
}