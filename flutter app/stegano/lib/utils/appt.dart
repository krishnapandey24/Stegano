import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Appt {
  static bool isValidPassword(String password) {
    if(password.length>30) return true;
    return password.length > 7 &&
        password.length < 128 &&
        password.contains(RegExp(r'[a-z]')) &&
        password.contains(RegExp(r'[A-Z]')) &&
        password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  }

  static bool isValidEmail(String email) {
    if (email.length > 51) return false;
    const pattern = r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$';
    final regExp = RegExp(pattern);
    return regExp.hasMatch(email);
  }

  static Future<Object?> pickImage() async {
    if (kIsWeb) {
      final ImagePicker picker = ImagePicker();
      final image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        return await image.readAsBytes();
      } else {
        return null;
      }
    } else {
      final ImagePicker picker = ImagePicker();
      final image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        return File(image.path);
      } else {
        return null;
      }
    }
  }

  static void fileSizeOverflowDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return const AlertDialog(
          title: Text("File size must be less than 10MB"),
        );
      },
    );
  }
}
