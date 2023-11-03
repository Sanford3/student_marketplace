import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:student_marketplace/screens/verification.dart';
import '../models/UserModel.dart';
import 'login.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();

  void signUp() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String cpassword = cpasswordController.text.trim();

    if (email == "" || password == "" || cpassword == "") {
      log("Please fill out all the fields!");
    }
    else if (password != cpassword) {
      log("Passwords don't Match");
    }
    else {
      UserCredential? userCredential;
      User? user;
      try {
        userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        log("User Created!");
      } on FirebaseAuthException catch (ex) {
        log(ex.code.toString());
      } catch (e) {
        log("Error: $e");
      }

      if (userCredential != null) {
        String uid = userCredential.user!.uid;
        UserModel newUser = UserModel(
            uid: uid,
            email: email,
            fullName: "",
            prn: ""
        );
        await FirebaseFirestore.instance.collection("users").doc(uid).set(
            newUser.toMap()).then((value) {
          log("New User Created");
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const LoginScreen();
          }));
        }
        ); // set wants a map to be passed
      }
    }
  }
    @override
    Widget build(BuildContext context) {
      return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    // height: MediaQuery.of(context).size.height*0.35,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    height: 340,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: <Color>[
                              Colors.white24,
                              Colors.purple.shade50,
                              Colors.purple.shade100,
                              Colors.purple.shade200,
                              Colors.purple.shade300,
                              Colors.purple.shade400,
                              Colors.purple.shade500,
                              Colors.purple.shade600,
                              Colors.purple.shade700,
                              Colors.purple.shade800,
                            ])),
                    child: SvgPicture.asset("assets/logos/signup.svg"),
                  ),
                  const SizedBox(height: 25),
                  const Text("Sign Up!",
                      style: TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  const Text(
                      "To have an Amazing experience along with your friends!"),
                  const SizedBox(height: 20),
                  Container(
                    // height: MediaQuery.of(context).size.height*0.50,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: 416,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        TextField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.email),
                            labelText: "Email",
                          ),
                        ),
                        TextField(
                          controller: passwordController,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.password),
                            labelText: "Password",
                          ),
                          obscureText: true,
                        ),
                        TextField(
                          controller: cpasswordController,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.password),
                            labelText: "Confirm Password",
                          ),
                          obscureText: true,
                        ),
                        const SizedBox(height: 15),
                        ElevatedButton(
                            onPressed: () {signUp();},
                            child: const Text("Sign Up",
                                style: TextStyle(fontWeight: FontWeight.bold))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already Signed Up?"),
                CupertinoButton(child: const Text("Log In"), onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()));
                })
              ],
            ),
          )
      );
    }
  }
