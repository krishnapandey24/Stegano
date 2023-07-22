import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  final String message;
  const LoadingDialog({super.key,this.message="Please Wait...."});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: SizedBox(
        height: 100,
        width: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16.0),
            Text(message),
          ],
        ),
      ),
    );
  }
}
