import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ImagePicker picker = ImagePicker();
  late File image;
  File? avatar;
  String username = '';
  final TextEditingController _newUsername = TextEditingController();
  TextEditingController _currentUsername = TextEditingController();

  pickImage() async {
    var selectedImage = await picker.pickImage(source: ImageSource.gallery);
    if (selectedImage == null) {
      return null;
    } else {
      image = File(selectedImage.path);
      setState(() {
        avatar = image;
      });
    }
  }

  Future<void> uploadImage() async {
    if (avatar != null) {
      String imageURL = '';
      await FirebaseFirestore.instance.collection('users').add(
        {
          'image': imageURL,
        },
      );
    }
  }

  Future<void> fetchUsername() async {
    String uid = FirebaseAuth.instance.currentUser?.uid ?? '';
    if (uid.isNotEmpty) {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (snapshot.exists && snapshot.data() != null) {
        setState(() {
          username = snapshot.data()!['username'] ?? '';
          _currentUsername = TextEditingController(text: username);
        });
      }
    }
  }

  Future<void> changeUsername() async {
    String newUsername = _newUsername.text.trim();

    if (newUsername.isNotEmpty) {
      String uid = FirebaseAuth.instance.currentUser?.uid ?? '';

      if (uid.isNotEmpty) {
        FirebaseFirestore.instance.collection('users').doc(uid).update({
          'username': newUsername,
        });

        setState(() {
          username = newUsername;
          _currentUsername.text = username;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Username updated successfully!",
              style: TextStyle(
                fontSize: 18,
                fontFamily: GoogleFonts.lato().toString(),
                fontWeight: FontWeight.w400,
                color: const Color.fromARGB(255, 32, 53, 96),
              ),
            ),
            backgroundColor: Colors.white,
          ),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUsername();
  }

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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  avatar != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: FileImage(avatar!),
                        )
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                            'https://media.istockphoto.com/id/1337144146/vector/default-avatar-profile-icon-vector.jpg?s=612x612&w=0&k=20&c=BIbFwuv7FxTWvh5S3vB6bkT0Qv8Vn8N5Ffseq84ClGI=',
                          ),
                        ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: IconButton(
                      onPressed: () async {
                        await pickImage();
                        uploadImage();
                      },
                      icon: Icon(
                        Icons.edit,
                        size: 20,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              TextField(
                readOnly: true,
                controller: _currentUsername,
                decoration: InputDecoration(
                  labelText: 'Current Username',
                  labelStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    fontFamily: GoogleFonts.lato().toString(),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _newUsername,
                decoration: InputDecoration(
                  labelText: 'New Username',
                  labelStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    fontFamily: GoogleFonts.lato().toString(),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  changeUsername();
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
                  "Change username",
                  style: TextStyle(
                    fontFamily: GoogleFonts.lato().toString(),
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () async {
                  FirebaseAuth.instance.signOut();
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
                  backgroundColor:
                      MaterialStateProperty.all(Theme.of(context).primaryColor),
                ),
                child: Text(
                  "Log out",
                  style: TextStyle(
                    fontFamily: GoogleFonts.lato().toString(),
                    color: Colors.white,
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
}
