import 'package:ar/firebase_options.dart';
import 'package:ar/screens/home_page.dart';
import 'package:ar/screens/login.dart';
import 'package:ar/screens/profile_page.dart';
import 'package:ar/screens/sign_up.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 32, 53, 96),
        fontFamily: GoogleFonts.lato().toString(),
        useMaterial3: true,
      ),
      routes: {
        '/signup': (context) => const SignUp(),
        '/login': (context) => const Login(),
        '/home': (context) => const HomePage(),
      },
      home: const ProfilePage(),
    );
  }
}
