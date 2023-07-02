import 'package:flutter/material.dart';

class DecodeImage extends StatefulWidget {
  const DecodeImage({Key? key}) : super(key: key);

  @override
  State<DecodeImage> createState() => _DecodeImageState();
}

class _DecodeImageState extends State<DecodeImage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: const Center(child: Text("DecodeImage"),)
    );
  }
}
