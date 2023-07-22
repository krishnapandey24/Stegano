import 'package:flutter/material.dart';
import 'package:stegano/utils/colors.dart';

import '../../utils/appt.dart';

class DrawerWidget extends StatefulWidget {
  final int index;

  const DrawerWidget({Key? key, required this.index})
      : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  late Future<bool> isLoggedIn;

  @override
  void initState() {
    super.initState();
    isLoggedIn = Appt.isLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(height: 50),
          ListTile(
            title: const Text('How it works?'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.pushNamed(
                  context, '/home'); // Navigate to the desired route
            },
          ),
          ListTile(
            title: const Text('About'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.pushNamed(
                  context, '/about'); // Navigate to the desired route
            },
          ),
          ListTile(
            title: const Text('Github'),
            hoverColor: kBlue,
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.pushNamed(
                  context, '/about'); // Navigate to the desired route
            },
          ),
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
                  return ListTile(
                    title: const Text('Sign up/ Login'),
                    onTap: () {
                      Navigator.pop(context); // Close the drawer
                      Navigator.pushNamed(
                          context, '/signup'); // Navigate to the desired route
                    },
                  );
                }
              },
            ),
          ]
        ],
      ),
    );
  }
}
