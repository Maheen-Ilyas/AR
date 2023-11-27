import 'package:ar/utilities/custom_app_bar.dart';
import 'package:ar/utilities/custom_text_field.dart';
import 'package:ar/utilities/error_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late final TextEditingController _username;
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _username = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _username.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          "Sign up",
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
          padding: const EdgeInsets.fromLTRB(16, 120, 16, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/signup.svg",
                height: 200,
                width: 200,
              ),
              const SizedBox(height: 25),
              CustomTextField(
                controller: _username,
                icon: Icon(
                  Icons.person,
                  size: 18,
                  color: Theme.of(context).primaryColor,
                ),
                hintText: "Username",
                type: TextInputType.text,
                enableSuggestions: true,
                obscureText: false,
              ),
              const SizedBox(height: 15),
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
                onPressed: () {
                  _signup();
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
                  "Register",
                  style: TextStyle(
                    fontFamily: GoogleFonts.lato().toString(),
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  _signup();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/login', (route) => false);
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
                  "Already registered? Login here!",
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

  Future<void> _signup() async {
    try {
      UserCredential userCred =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCred.user?.uid)
          .set(
        {
          'email': _email.text,
          '_username': _username.text,
        },
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        errorDialogBox(context, "Weak password");
      } else if (e.code == 'invalid-email') {
        errorDialogBox(context, "Invalid password");
      } else if (e.code == 'email-already-in-use') {
        errorDialogBox(context, "Email already in use");
      }
    } catch (e) {
      errorDialogBox(context, e.toString());
    }
  }
}
