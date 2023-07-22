import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stegano/ui/widgets/button_with_icon.dart';
import 'package:stegano/utils/constants.dart';
import 'package:stegano/utils/styles.dart';

import '../../utils/appt.dart';
import 'nav_bar_text.dart';
import "package:universal_html/html.dart" as html;

class NavBar extends StatefulWidget {
  final int index;
  final bool atHome;
  final Function() openDrawer;

  const NavBar(
      {Key? key,
      required this.index,
      required this.atHome,
      required this.openDrawer})
      : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  late Future<bool> isLoggedIn;

  @override
  void initState() {
    super.initState();
    isLoggedIn = Appt.isLoggedIn();
  }

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
        child: GestureDetector(
          onTap: () {
            if (!widget.atHome) {
              Navigator.of(context, rootNavigator: true).pushNamed('/');
            }
          },
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
      ),
      title: GestureDetector(
        onTap: () {
          if (!widget.atHome) {
            Navigator.of(context, rootNavigator: true).pushNamed('/');
          }
        },
        child: const Text(
          appName,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: widget.openDrawer,
          child: const Icon(Icons.menu),
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
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                if (!widget.atHome) {
                  Navigator.of(context, rootNavigator: true).pushNamed(
                    '/',
                  );
                }
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
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
                ],
              ),
            ),
          ),
          const Spacer(),
          ...navBarTexts()
        ],
      ),
    );
  }

  List<Widget> navBarTexts() {
    List<Widget> navBarTexts = [
      NavBarText(text: "How it works?", onTap: () {}),
      const SizedBox(width: 20),
      NavBarText(text: "About", onTap: () {}),
      const SizedBox(width: 20),
      NavBarText(
          text: "Github",
          onTap: () {
            if (kIsWeb) {
              html.window.open(
                  'https://www.github.com/krishnapandey24/Stegano', '_blank');
            }
          }),
      const SizedBox(width: 40),
      if (widget.index == 10) ...[
        FutureBuilder<bool>(
          future: isLoggedIn,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting ||
                snapshot.hasError) {
              return const SizedBox();
            } else {
              bool data = snapshot.data!;
              if (data) {
                return const SizedBox();
              }
              return ButtonWithIcon(
                text: Text("Login", style: navBarTextStyle),
                onTap: () {
                  Navigator.pushNamed(context, '/signup');
                },
                padding: 20,
              );
            }
          },
        ),
      ]
    ];
    return navBarTexts;
  }
}
