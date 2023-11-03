import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_marketplace/models/UserModel.dart';
import 'package:student_marketplace/screens/departments.dart';

class VerificationScreen extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;
  const VerificationScreen({super.key, required this.userModel, required this.firebaseUser});

  @override
  State<VerificationScreen> createState() => _VerificationState();
}

class _VerificationState extends State<VerificationScreen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController prnController = TextEditingController();

  void getUserDetailsAndPutIntoUserModel () async {

    String name = nameController.text.trim();
    String prn = prnController.text.trim();

    UserCredential? userCredential;

    // if(userCredential!=null) {
    //   String uid = userCredential.user!.uid;

    // widget.userModel.uid = widget.firebaseUser.uid;
    widget.userModel.fullName = name;
    widget.userModel.prn = prn;

    log(widget.userModel.fullName.toString());

    await FirebaseFirestore.instance.collection("users").doc(widget.userModel.uid).set(widget.userModel.toMap())
        .then((value) => log("Data added Successfully"));

    // }
    Navigator.push(context, MaterialPageRoute(builder: (context)=> DepartmentScreen(userModel: widget.userModel, firebaseUser: widget.firebaseUser)));
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
                ElevatedButton(onPressed: (){
                  getUserDetailsAndPutIntoUserModel();
                }, child: const Text("Go to next Page"))
              ],
            ),
          )
      ),
    );
  }
}