import 'package:flutter/material.dart';
import 'package:stegano/utils/colors.dart';

class ButtonWithIcon extends StatelessWidget {
  final Text text;
  final Function() onTap;
  final double padding;

  const ButtonWithIcon({super.key, required this.text, required this.onTap,this.padding=25});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(padding),
        shape: const StadiumBorder(),
        backgroundColor: kBlue,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          text,
          const SizedBox(width: 5),
          const Icon(Icons.arrow_forward_ios)
        ],
      ),
    );
  }

}
