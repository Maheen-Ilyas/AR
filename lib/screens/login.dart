import 'package:ar/utilities/custom_app_bar.dart';
import 'package:ar/utilities/custom_text_field.dart';
import 'package:ar/utilities/error_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:developer' as dev show log;
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          "Login",
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontFamily: GoogleFonts.lato().toString(),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 150, 16, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/login.svg",
                height: 200,
                width: 200,
              ),
              const SizedBox(height: 25),
              CustomTextField(
                controller: _email,
                icon: Icon(
                  Icons.email,
                  size: 18,
                  color: Theme.of(context).primaryColor,
                ),
                hintText: "Email",
                type: TextInputType.emailAddress,
                enableSuggestions: true,
                obscureText: false,
              ),
              const SizedBox(height: 15),
              CustomTextField(
                controller: _password,
                icon: Icon(
                  Icons.lock,
                  size: 18,
                  color: Theme.of(context).primaryColor,
                ),
                hintText: "Password",
                type: TextInputType.text,
                enableSuggestions: false,
                obscureText: true,
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () async {
                  _login();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/home', (route) => false);
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                    const Size(
                      double.infinity,
                      60,
                    ),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all(Theme.of(context).primaryColor),
                ),
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontFamily: GoogleFonts.lato().toString(),
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  _login();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/signup', (route) => false);
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                    const Size(
                      double.infinity,
                      60,
                    ),
                  ),
                  backgroundColor: MaterialStateColor.resolveWith(
                    (states) => const Color.fromARGB(0, 0, 0, 0),
                  ),
                ),
                child: Text(
                  "Don't have an account? Sign up here!",
                  style: TextStyle(
                    fontFamily: GoogleFonts.lato().toString(),
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    try {
      final userCredential = FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );
      dev.log(userCredential.toString());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        errorDialogBox(context, "User not found");
      } else if (e.code == 'wrong-password') {
        errorDialogBox(context, "Wrong password");
      } else {
        errorDialogBox(context, e.code);
      }
    } catch (e) {
      errorDialogBox(context, e.toString());
    }
  }
}
