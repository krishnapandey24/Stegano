import 'package:flutter/material.dart';
import 'package:stegano/ui/create_account.dart';
import 'package:stegano/ui/decode_image.dart';
import 'package:stegano/ui/encode_image.dart';
import 'package:stegano/ui/home_screen.dart';
import 'package:stegano/utils/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Stegano",
      theme: ThemeData(
        fontFamily: "BasierCircle",
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.black, // Set the default background color as black
        textTheme: const TextTheme(

          bodyLarge: TextStyle(color: Colors.white), // Set the default text color as white
          bodyMedium: TextStyle(color: Colors.white),
          bodySmall: TextStyle(color: Colors.white),
          // You can customize other text styles as needed
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent, // Set your default color here
        ),
      ),
      initialRoute: '/',
      routes: {
        '/signup': (context) => CreateAccount(toEncode: ModalRoute.of(context)?.settings.arguments as bool?),
        '/encode': (context) => const EncodeImage(),
        '/decode': (context) => const DecodeImage(),
      },
      home: const HomeScreen(),
    );
  }
}
