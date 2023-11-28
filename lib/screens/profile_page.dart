import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 25,
        ),
        title: Text(
          "Profile",
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontFamily: GoogleFonts.lato().toString(),
          ),
        ),
        centerTitle: true,
        elevation: 15,
        flexibleSpace: Container(
          height: 150,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor,
                const Color.fromARGB(255, 75, 108, 183),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            DrawerHeader(
              child: Text(
                "Menu",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  fontFamily: GoogleFonts.lato().toString(),
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            ListTile(
              title: Text(
                "Logout",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontFamily: GoogleFonts.lato().toString(),
                  fontSize: 18,
                ),
              ),
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/login', (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
