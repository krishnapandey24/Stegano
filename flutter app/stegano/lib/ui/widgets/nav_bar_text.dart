import 'package:flutter/material.dart';

import '../../utils/colors.dart';
class NavBarText extends StatefulWidget {
  final String text;


  const NavBarText({super.key, required this.text});

  @override
  State<NavBarText> createState() {
    return _NavBarTextState();
  }
}

class _NavBarTextState extends State<NavBarText> {
  Color _color = Colors.white;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) => setState(() {
        _color = kBlue;
      }),
      onExit: (event) => setState(() {
        _color = Colors.white;
      }),
      child: GestureDetector(
        onTap: (){

        },
        child: Text(
          widget.text,
          style:
          TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: _color),
        ),
      ),
    );
  }

}
