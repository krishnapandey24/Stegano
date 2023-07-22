import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stegano/utils/mobile_login_utils.dart';
import 'package:stegano/utils/web_login_utils.dart';

import 'colors.dart';

class Appt {
  static bool isValidPassword(String password) {
    if (password.length > 30) return true;
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

  static Future<Uint8List?> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      return await image.readAsBytes();
    } else {
      return null;
    }
  }

  static void fileSizeOverflowDialog(BuildContext context) {
    showAlertDialog(context, "File size must be less than 10MB");
  }

  static void showAlertDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(message),
        );
      },
    );
  }

  static void toast(String message, BuildContext context) {
    if (kIsWeb) {
      showAlertDialog(context, message);
    } else {
      Fluttertoast.showToast(
        backgroundColor: Colors.black.withOpacity(0.86),
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 16.0,
      );
    }
  }

  static Future<bool> isLoggedIn() async {
    if (kIsWeb) {
      return WebLoginUtils.isLoggedIn();
    } else {
      return MobileLoginUtils.isLoggedIn();
    }
  }

  static void showLoading(BuildContext context, [String? message]) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            content: Center(
              child: Container(
                padding: const EdgeInsets.all(25),
                decoration: const BoxDecoration(
                  color: kFieldBlack,
                  borderRadius: BorderRadius.all(Radius.circular(16))
                ),
                child: Column (
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 10),
                    Text(message ?? "Please wait...",style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w400),)
                  ],
                ),
              ),
            ),
          );
        },
      );
    }

}
