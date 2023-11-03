import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:student_marketplace/screens/comps.dart';
import '../models/UserModel.dart';
import 'fe.dart';
import 'login.dart';

class DepartmentScreen extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;
  const DepartmentScreen({super.key, required this.userModel, required this.firebaseUser});

  @override
  State<DepartmentScreen> createState() => _DepartmentScreenState();
}

class _DepartmentScreenState extends State<DepartmentScreen> {

  final List<String> arr = ["First year", "Computer", "IT", "AI & DS", "EXTC", "Chemical"];

  void logout() async {
    await FirebaseAuth.instance.signOut();
    log("User logged out.");
    Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          actions: [
            ElevatedButton(onPressed: (){logout();},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
              ),
                child: const Icon(Icons.logout_outlined, color: Colors.black)
            )
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              children: [
                const Text(
                  "Select your Department",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                const SizedBox(height: 50),
                Department(department: arr[0], imageUrl: "assets/images/departments/fy.png", firebaseUser: widget.firebaseUser, userModel: widget.userModel),
                const SizedBox(height: 50),
                Department(department: arr[1], imageUrl: "assets/images/departments/comp.jpg", firebaseUser: widget.firebaseUser, userModel: widget.userModel),
                const SizedBox(height: 50),
                Department(department: arr[2], imageUrl: "assets/images/departments/it.jpg", firebaseUser: widget.firebaseUser, userModel: widget.userModel),
                const SizedBox(height: 50),
                Department(department: arr[3], imageUrl: "assets/images/departments/aids.jpg", firebaseUser: widget.firebaseUser, userModel: widget.userModel),
                const SizedBox(height: 50),
                Department(department: arr[4], imageUrl: "assets/images/departments/extc.jpg", firebaseUser: widget.firebaseUser, userModel: widget.userModel),
                const SizedBox(height: 50),
                Department(department: arr[5], imageUrl: "assets/images/departments/chem.jpg", firebaseUser: widget.firebaseUser, userModel: widget.userModel),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Department extends StatefulWidget {
  final String department;
  final String imageUrl;
  final UserModel userModel;
  final User firebaseUser;
  const Department({super.key, required this.department, required this.imageUrl, required this.userModel, required this.firebaseUser});

  @override
  State<Department> createState() => _DepartmentState();
}

class _DepartmentState extends State<Department> {
  @override
  Widget build(BuildContext context) {

    double deviceWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        if (widget.department == "First year") {
          // Navigate to FE department screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FeDepartmentScreen(userModel: widget.userModel, firebaseUser: widget.firebaseUser),
            ),
          );
        } else {
          // Navigate to Comps department screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CompsDepartmentScreen(userModel: widget.userModel, firebaseUser: widget.firebaseUser),
            ),
          );
        }
      },
    child: Container(
        height: 150,
        width: deviceWidth,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(6, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 150,
              height: 140.0,
              child: Image.asset(widget.imageUrl),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.department,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const Text(
                  "Department",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
