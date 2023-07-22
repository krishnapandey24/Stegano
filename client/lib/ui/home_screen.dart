import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stegano/ui/widgets/drawer.dart';
import 'package:stegano/ui/widgets/nav_bar.dart';
import 'package:stegano/ui/widgets/button_with_icon.dart';
import 'package:stegano/utils/constants.dart';
import 'package:stegano/utils/mobile_login_utils.dart';
import 'package:stegano/utils/web_login_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      drawer: const DrawerWidget(index: 10),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            NavBar(
                index: 10,
                atHome: true,
                openDrawer: () {
                  _scaffoldKey.currentState?.openDrawer(); // Open the drawer
                }),
            ScreenTypeLayout.builder(
              desktop: (BuildContext context) => mainContainer(true),
              mobile: (BuildContext context) => mainContainer(false),
            )
          ],
        ),
      ),
    );
  }

  Container mainContainer(bool isWeb) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width! / 10, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 70),
          Text(
            "Secure Image Steganography",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isWeb ? 50 : 30,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 40),
          Text(
            subDescription,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isWeb ? 20 : 15,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 50),
          Wrap(
            alignment: WrapAlignment.center,
            runSpacing: 20,
            children: [
              ButtonWithIcon(
                text: const Text(
                  "Encode Image",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                onTap: () => Navigator.of(context, rootNavigator: true)
                    .pushNamed(
                        WebLoginUtils.isLoggedIn() ? '/encode' : '/signup',
                        arguments: true),
              ),
              const SizedBox(width: 20),
              ButtonWithIcon(
                text: const Text(
                  "Decode Image",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                onTap: () => Navigator.of(context, rootNavigator: true)
                    .pushNamed(
                        WebLoginUtils.isLoggedIn() ? '/decode' : '/signup',
                        arguments: false),
              ),
              const SizedBox(width: 20),
            ],
          )
        ],
      ),
    );
  }

  Container mobileContainer() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width! / 10, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 70),
          const Text(
            "Secure Image Steganography",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 40),
          const Text(
            subDescription,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 50),
          ButtonWithIcon(
            text: const Text(
              "Encode Image",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            onTap: () async {
              bool isLoggedIn = await MobileLoginUtils.isLoggedIn();
              if (context.mounted) {
                Navigator.of(context, rootNavigator: true).pushNamed(
                  isLoggedIn ? '/encode' : '/signup',
                );
              }
            },
          ),
          const SizedBox(height: 20),
          ButtonWithIcon(
            text: const Text(
              "Decode Image",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            onTap: () async {
              bool isLoggedIn = await MobileLoginUtils.isLoggedIn();
              if (context.mounted) {
                Navigator.of(context, rootNavigator: true).pushNamed(
                  isLoggedIn ? '/decode' : '/signup',
                );
              }
            },
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }
}
