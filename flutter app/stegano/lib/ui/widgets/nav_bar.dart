import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stegano/ui/widgets/button_with_icon.dart';
import 'package:stegano/utils/constants.dart';
import 'package:stegano/utils/styles.dart';

import 'nav_bar_text.dart';

class NavBar extends StatefulWidget {
  final int index;
  const NavBar({Key? key, required this.index}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => mobileNavBar(),
      desktop: (BuildContext context) => desktopNavBar(),
    );
  }

  AppBar mobileNavBar() {
    return AppBar(
      leading: Center(
        child: SvgPicture.asset(
          "assets/icons/logo.svg",
          height: 30,
          width: 30,
          colorFilter: const ColorFilter.mode(
            Colors.white,
            BlendMode.srcIn,
          ),
        ),
      ),
      title: const Text(
        appName,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      actions: [
        GestureDetector(
          child: const Icon(Icons.menu),
          onTap: () {
            // TODO implement menu
          },
        ),
        const SizedBox(width: 20),
      ],
    );
  }

  desktopNavBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 70, vertical: 25),
      child: Row(
        children: [
          SvgPicture.asset(
            "assets/icons/logo.svg",
            height: 60,
            width: 60,
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 30),
          const Text(
            appName,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          const NavBarText(text: "How it works?"),
          const SizedBox(width: 20),
          const NavBarText(text: "About"),
          const SizedBox(width: 20),
          const NavBarText(text: "Contact"),
          const SizedBox(width: 20),
          const NavBarText(text: "Github"),
          const SizedBox(width: 40),
          ButtonWithIcon(
            text: Text("Login", style: navBarTextStyle),
            onTap: () {},
            padding: 20,
          )
        ],
      ),
    );
  }

  List<Widget> navBarTexts(){
    List<Widget> navBarTexts= [
      const NavBarText(text: "How it works?"),
      const SizedBox(width: 20),
      const NavBarText(text: "About"),
      const SizedBox(width: 20),
      const NavBarText(text: "Contact"),
      const SizedBox(width: 20),
      const NavBarText(text: "Github"),
      const SizedBox(width: 40),
      ButtonWithIcon(
        text: Text("Login", style: navBarTextStyle),
        onTap: () {},
        padding: 20,
      )
    ];
    if(widget.index==10) return navBarTexts;
    navBarTexts.removeAt(widget.index);
    return navBarTexts;
  }
}
