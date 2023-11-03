import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_marketplace/models/UserModel.dart';
import 'package:student_marketplace/screens/departments.dart';
import 'package:student_marketplace/screens/login.dart';  // Import your login page

class VerificationScreen extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;

  const VerificationScreen({Key? key, required this.userModel, required this.firebaseUser})
      : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationState();
}

class _VerificationState extends State<VerificationScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController prnController = TextEditingController();

  void getImageAndNavigateToLogin() async {
    final ImagePicker imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      Navigator.push(context, MaterialPageRoute(builder: (context)=> DepartmentScreen(userModel: widget.userModel, firebaseUser: widget.firebaseUser)));
    }
  }

  void getUserDetailsAndPutIntoUserModel() async {
    String name = nameController.text.trim();
    String prn = prnController.text.trim();

    widget.userModel.fullName = name;
    widget.userModel.prn = prn;

    log(widget.userModel.fullName.toString());

    await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.userModel.uid)
        .set(widget.userModel.toMap())
        .then((value) => log("Data added Successfully"));

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DepartmentScreen(
          userModel: widget.userModel,
          firebaseUser: widget.firebaseUser,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              const Text("Please Verify that you are a Student of Thadomal."),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Enter Your Name",
                ),
              ),
              TextField(
                controller: prnController,
                decoration: const InputDecoration(
                  labelText: "Enter Your Prn Number",
                ),
              ),
              const Text("Enter Your Id card image here."),
              ElevatedButton(
                onPressed: () {
                  getImageAndNavigateToLogin();
                },
                child: const Text("Pick Image to verify"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
