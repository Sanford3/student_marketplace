import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_marketplace/models/bookModel.dart';
import 'package:student_marketplace/screens/booklisting.dart';
import 'package:uuid/uuid.dart';

import '../models/UserModel.dart';

class CompsDepartmentScreen extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;
  const CompsDepartmentScreen({super.key, required this.userModel, required this.firebaseUser});

  @override
  State<CompsDepartmentScreen> createState() => _CompsDepartmentScreenState();
}

class _CompsDepartmentScreenState extends State<CompsDepartmentScreen> {

  var sems = [3, 4, 5, 6, 7, 8];
  final List<String> sem3 = ["Digital Logic & Computer Architecture", "Computer Graphics", "Discrete Structures and Graph Theory", "Data Structures", "JAVA", "Maths"];
  final List<String> sem4 = ["Maths", "Analysis Of Algorithm", "Database Management System", "Operating Systems", "Microprocessors", "Python"];
  final List<String> sem5 = ["Computer Networks", "Data Warehouse & Mining", "Software Engineering", "Theoretical Computer Science", "Internet Programming", "Professional Communication Ethics"];
  final List<String> sem6 = ["System Prog & Compiler Construction", "Cryptography & System Security", "Mobile Computing", "Artificial Intelligence", "Internet of Things", "Digital Signal & Image Processing"];
  final List<String> sem7 = ["Machine Learning", "Quantum Computing", "Natural Language Processing", "Augmented and Virtual Reality", "BlockChain", "Information Retrieval"];
  final List<String> sem8 = ["Distributed Computing", "Deep Learning", "Digital Forensic", "Applied Data Science", "Optimization in Machine Learning", "High Performance Computing", "Social Media Analytics"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comps"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [

              const SizedBox(height: 40),
          Text("Sem ${sems[0]} Subjects", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
            const SizedBox(height: 25),
            Subject(subjectName: sem3[0], sem: 3, imageUrl: "assets/images/departments/fy.png", userModel: widget.userModel, firebaseUser: widget.firebaseUser,),
              const SizedBox(height: 40),
              Subject(subjectName: sem3[1], sem: 3, imageUrl: "assets/images/departments/fy.png", userModel: widget.userModel, firebaseUser: widget.firebaseUser,),
              const SizedBox(height: 40),
              Subject(subjectName: sem3[2], sem: 3, imageUrl: "assets/images/departments/fy.png", userModel: widget.userModel, firebaseUser: widget.firebaseUser,),
              const SizedBox(height: 40),
              Subject(subjectName: sem3[3], sem: 3, imageUrl: "assets/images/departments/fy.png", userModel: widget.userModel, firebaseUser: widget.firebaseUser,),
              const SizedBox(height: 40),
              Subject(subjectName: sem3[4], sem: 3, imageUrl: "assets/images/departments/fy.png", userModel: widget.userModel, firebaseUser: widget.firebaseUser,),
              const SizedBox(height: 40),
              Subject(subjectName: sem3[5], sem: 3, imageUrl: "assets/images/departments/fy.png", userModel: widget.userModel, firebaseUser: widget.firebaseUser,),
              const SizedBox(height: 80),

              Text("Sem ${sems[1]} Subjects", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
              const SizedBox(height: 25),
              Subject(subjectName: sem4[0], sem: 4, imageUrl: "assets/images/departments/fy.png", userModel: widget.userModel, firebaseUser: widget.firebaseUser,),
              const SizedBox(height: 40),
              Subject(subjectName: sem4[1], sem: 4, imageUrl: "assets/images/departments/fy.png", userModel: widget.userModel, firebaseUser: widget.firebaseUser,),
              const SizedBox(height: 40),
              Subject(subjectName: sem4[2], sem: 4, imageUrl: "assets/images/departments/fy.png", userModel: widget.userModel, firebaseUser: widget.firebaseUser,),
              const SizedBox(height: 40),
              Subject(subjectName: sem4[3], sem: 4, imageUrl: "assets/images/departments/fy.png", userModel: widget.userModel, firebaseUser: widget.firebaseUser,),
              const SizedBox(height: 40),
              Subject(subjectName: sem4[4], sem: 4, imageUrl: "assets/images/departments/fy.png", userModel: widget.userModel, firebaseUser: widget.firebaseUser,),
              const SizedBox(height: 40),
              Subject(subjectName: sem4[5], sem: 4, imageUrl: "assets/images/departments/fy.png", userModel: widget.userModel, firebaseUser: widget.firebaseUser,),
              const SizedBox(height: 80),

              Text("Sem ${sems[2]} Subjects", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
              const SizedBox(height: 25),
              Subject(subjectName: sem5[0], sem: 5, imageUrl: "assets/images/departments/fy.png", userModel: widget.userModel, firebaseUser: widget.firebaseUser,),
              const SizedBox(height: 40),
              Subject(subjectName: sem5[1], sem: 5, imageUrl: "assets/images/departments/fy.png", userModel: widget.userModel, firebaseUser: widget.firebaseUser,),
              const SizedBox(height: 40),
              Subject(subjectName: sem5[2], sem: 5, imageUrl: "assets/images/departments/fy.png", userModel: widget.userModel, firebaseUser: widget.firebaseUser,),
              const SizedBox(height: 40),
              Subject(subjectName: sem5[3], sem: 5, imageUrl: "assets/images/departments/fy.png", userModel: widget.userModel, firebaseUser: widget.firebaseUser,),
              const SizedBox(height: 40),
              Subject(subjectName: sem5[4], sem: 5, imageUrl: "assets/images/departments/fy.png", userModel: widget.userModel, firebaseUser: widget.firebaseUser,),
              const SizedBox(height: 40),
              Subject(subjectName: sem5[5], sem: 5, imageUrl: "assets/images/departments/fy.png", userModel: widget.userModel, firebaseUser: widget.firebaseUser,),
              const SizedBox(height: 80),

              Text("Sem ${sems[3]} Subjects", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
              const SizedBox(height: 25),
              Subject(subjectName: sem6[0], sem: 6, imageUrl: "assets/images/departments/fy.png", userModel: widget.userModel, firebaseUser: widget.firebaseUser,),
              const SizedBox(height: 40),
              Subject(subjectName: sem6[1], sem: 6, imageUrl: "assets/images/departments/fy.png", userModel: widget.userModel, firebaseUser: widget.firebaseUser,),
              const SizedBox(height: 40),
              Subject(subjectName: sem6[2], sem: 6, imageUrl: "assets/images/departments/fy.png", userModel: widget.userModel, firebaseUser: widget.firebaseUser,),
              const SizedBox(height: 40),
              Subject(subjectName: sem6[3], sem: 6, imageUrl: "assets/images/departments/fy.png", userModel: widget.userModel, firebaseUser: widget.firebaseUser,),
              const SizedBox(height: 40),
              Subject(subjectName: sem6[4], sem: 6, imageUrl: "assets/images/departments/fy.png", userModel: widget.userModel, firebaseUser: widget.firebaseUser,),
              const SizedBox(height: 40),
              Subject(subjectName: sem6[5], sem: 6, imageUrl: "assets/images/departments/fy.png", userModel: widget.userModel, firebaseUser: widget.firebaseUser,),
              const SizedBox(height: 80),

              Text("Sem ${sems[4]} Subjects", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
              const SizedBox(height: 25),
              Subject(subjectName: sem7[0], sem: 7, imageUrl: "assets/images/departments/fy.png", userModel: widget.userModel, firebaseUser: widget.firebaseUser,),
              const SizedBox(height: 40),
              Subject(subjectName: sem7[1], sem: 7, imageUrl: "assets/images/departments/fy.png", userModel: widget.userModel, firebaseUser: widget.firebaseUser,),
              const SizedBox(height: 40),
              Subject(subjectName: sem7[2], sem: 7, imageUrl: "assets/images/departments/fy.png", userModel: widget.userModel, firebaseUser: widget.firebaseUser,),
              const SizedBox(height: 40),
              Subject(subjectName: sem7[3], sem: 7, imageUrl: "assets/images/departments/fy.png", userModel: widget.userModel, firebaseUser: widget.firebaseUser,),
              const SizedBox(height: 40),
              Subject(subjectName: sem7[4], sem: 7, imageUrl: "assets/images/departments/fy.png", userModel: widget.userModel, firebaseUser: widget.firebaseUser,),
              const SizedBox(height: 40),
              Subject(subjectName: sem7[5], sem: 7, imageUrl: "assets/images/departments/fy.png", userModel: widget.userModel, firebaseUser: widget.firebaseUser,),
              const SizedBox(height: 80),

              Text("Sem ${sems[5]} Subjects", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
              const SizedBox(height: 25),
              Subject(subjectName: sem8[0], sem: 8, imageUrl: "assets/images/departments/fy.png", userModel: widget.userModel, firebaseUser: widget.firebaseUser,),
              const SizedBox(height: 40),
              Subject(subjectName: sem8[1], sem: 8, imageUrl: "assets/images/departments/fy.png", userModel: widget.userModel, firebaseUser: widget.firebaseUser,),
              const SizedBox(height: 40),
              Subject(subjectName: sem8[2], sem: 8, imageUrl: "assets/images/departments/fy.png", userModel: widget.userModel, firebaseUser: widget.firebaseUser,),
              const SizedBox(height: 40),
              Subject(subjectName: sem8[3], sem: 8, imageUrl: "assets/images/departments/fy.png", userModel: widget.userModel, firebaseUser: widget.firebaseUser,),
              const SizedBox(height: 40),
              Subject(subjectName: sem8[4], sem: 8, imageUrl: "assets/images/departments/fy.png", userModel: widget.userModel, firebaseUser: widget.firebaseUser,),
              const SizedBox(height: 40),
              Subject(subjectName: sem8[5], sem: 8, imageUrl: "assets/images/departments/fy.png", userModel: widget.userModel, firebaseUser: widget.firebaseUser,),
              const SizedBox(height: 80),
            ],
          ),
        ),
      )
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
      department: "Comps",
      semester: null,
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
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
    );
  }
}
