import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stegano/ui/widgets/nav_bar.dart';

class EncodeImage extends StatefulWidget {
  const EncodeImage({Key? key}) : super(key: key);

  @override
  State<EncodeImage> createState() => _EncodeImageState();
}

class _EncodeImageState extends State<EncodeImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const NavBar(index: 9),
            ScreenTypeLayout.builder(
              desktop: (BuildContext context) => mainContainer(true),
              mobile: (BuildContext context) => mainContainer(false),
            )
          ],
        ),
      ),
    );
  }

  Container mainContainer(bool isWeb){
    return Container();
  }
}
