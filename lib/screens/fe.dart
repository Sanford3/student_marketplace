import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/bookModel.dart';
import '../models/UserModel.dart';
import 'booklisting.dart';

class FeDepartmentScreen extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;
  const FeDepartmentScreen({super.key, required this.userModel, required this.firebaseUser});

  @override
  State<FeDepartmentScreen> createState() => _FeDepartmentScreenState();
}

class _FeDepartmentScreenState extends State<FeDepartmentScreen> {

  var sems = [1, 2];
  final List<String> sem1 = ["Mechanics", "Physics", "Chemistry", "Maths", "BEE"];
  final List<String> sem2 = ["Maths", "Physics", "Chemistry", "Drawing", "C programming"];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Comps Department", style: TextStyle(color: Colors.black)),
            centerTitle: true,
            backgroundColor: Colors.grey,
            elevation: 1,
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [

                  const SizedBox(height: 40),
                  Text("Sem ${sems[0]} Subjects", style: GoogleFonts.delaGothicOne(fontSize: 25)),
                  const SizedBox(height: 25),
                  Subject(subjectName: sem1[0], sem: 1, imageUrl: "assets/images/departments/fy.png", userModel: widget.userModel, firebaseUser: widget.firebaseUser,),
                  const SizedBox(height: 40),
                  Subject(subjectName: sem1[1], sem: 1, imageUrl: "assets/images/departments/fy.png", userModel: widget.userModel, firebaseUser: widget.firebaseUser,),
                  const SizedBox(height: 40),
                  Subject(subjectName: sem1[2], sem: 1, imageUrl: "assets/images/departments/fy.png", userModel: widget.userModel, firebaseUser: widget.firebaseUser,),
                  const SizedBox(height: 40),
                  Subject(subjectName: sem1[3], sem: 1, imageUrl: "assets/images/departments/fy.png", userModel: widget.userModel, firebaseUser: widget.firebaseUser,),
                  const SizedBox(height: 40),
                  Subject(subjectName: sem1[4], sem: 1, imageUrl: "assets/images/departments/fy.png", userModel: widget.userModel, firebaseUser: widget.firebaseUser,),
                  const SizedBox(height: 40),

                  Text("Sem ${sems[1]} Subjects", style: GoogleFonts.delaGothicOne(fontSize: 25)),
                  const SizedBox(height: 25),
                  Subject(subjectName: sem2[0], sem: 2, imageUrl: "assets/images/departments/fy.png", userModel: widget.userModel, firebaseUser: widget.firebaseUser,),
                  const SizedBox(height: 40),
                  Subject(subjectName: sem2[1], sem: 2, imageUrl: "assets/images/departments/fy.png", userModel: widget.userModel, firebaseUser: widget.firebaseUser,),
                  const SizedBox(height: 40),
                  Subject(subjectName: sem2[2], sem: 2, imageUrl: "assets/images/departments/fy.png", userModel: widget.userModel, firebaseUser: widget.firebaseUser,),
                  const SizedBox(height: 40),
                  Subject(subjectName: sem2[3], sem: 2, imageUrl: "assets/images/departments/fy.png", userModel: widget.userModel, firebaseUser: widget.firebaseUser,),
                  const SizedBox(height: 40),
                  Subject(subjectName: sem2[4], sem: 2, imageUrl: "assets/images/departments/fy.png", userModel: widget.userModel, firebaseUser: widget.firebaseUser,),
                  const SizedBox(height: 40),

                ],
              ),
            ),
          )
      ),
    );
  }
}

class Subject extends StatefulWidget {
  final String subjectName;
  final int sem;
  final String imageUrl;
  final UserModel userModel;
  final User firebaseUser;
  const Subject({super.key, required this.subjectName, required this.sem, required this.imageUrl, required this.userModel, required this.firebaseUser});

  @override
  State<Subject> createState() => _SubjectState();
}

class _SubjectState extends State<Subject> {

  late BookModel newBookModel;

  @override
  void initState() {
    super.initState();

    // Initialize newBookModel here using widget properties
    newBookModel = BookModel(
      uid: "",
      sellerId: widget.firebaseUser.uid,
      sellerName: widget.userModel.fullName,
      subjectName: widget.subjectName,
      department: "First year",
      semester: widget.sem,
      bookEdition: "",
      bookAuthor: "",
      bookName: "",
      imageUrl: "",
    );
  }


  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return
      InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>BookListingScreen(bookModel: newBookModel, firebaseUser: widget.firebaseUser, userModel: widget.userModel, semester: widget.sem)));
        },
        child: Container(
          height: 60,
          width: deviceWidth,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(3, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // SizedBox(
              //   width: 150,
              //   height: 140.0,
              //   child: Image.asset(widget.imageUrl),
              // ),
              Text(
                  widget.subjectName,
                  style: GoogleFonts.satisfy(fontSize: 24)
              ),
            ],
          ),
        ),
      );
  }
}
