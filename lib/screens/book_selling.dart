import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../models/UserModel.dart';
import '../models/bookModel.dart';

class BookSellingScreen extends StatefulWidget {
  final BookModel bookModel;
  final UserModel userModel;
  final User firebaseUser;
  final int semester;
  const BookSellingScreen({super.key, required this.bookModel, required this.userModel, required this.firebaseUser, required this.semester});

  @override
  State<BookSellingScreen> createState() => _BookSellingScreenState();
}

class _BookSellingScreenState extends State<BookSellingScreen> {

  TextEditingController bookNameController = TextEditingController();
  TextEditingController bookEditionController = TextEditingController();
  TextEditingController authorNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  File? imageFile;
  Future selectImage (ImageSource source) async{
    final pickedFile = await ImagePicker().pickImage(source: source); // ImagePicker returns an Xfile
    log("Image Picked Successfully");
    if(pickedFile!=null){
      imageFile = File(pickedFile.path);
      setState(() {});
    }
  }

  void showPhotoOptions () {
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: const Text("Upload Profile Picture"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text("Select from Gallery"),
              onTap: () {
                Navigator.pop(context);
                selectImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: const Text("Take a Photo"),
              onTap: () {
                Navigator.pop(context);
                selectImage(ImageSource.camera);
              },
            ),
          ],
        ),
      );
    });
    setState(() {});
  }

  void sell () async {

    String bookName = bookNameController.text.trim();
    String bookEdition = bookEditionController.text.trim();
    String authorName = authorNameController.text.trim();
    String price = priceController.text.trim();
    String description = descriptionController.text.trim();

    if(bookName == "" || bookEdition == "" || authorName == ""){
      showDialog(context: context, builder: (BuildContext context){
        return const AlertDialog(title: Text("Please fill Book details"));
      });
    }
    else {
      try{
        String uid = const Uuid().v1();
        BookModel newBookModel = BookModel(
            uid: uid,
            sellerId: widget.firebaseUser.uid,
            sellerName: widget.userModel.fullName.toString(),
            subjectName: widget.bookModel.subjectName,
            bookName: bookName,
            bookAuthor: authorName,
            bookEdition: bookEdition,
            bookPrice: price,
            description: description,
            department: widget.bookModel.department,
            semester: widget.semester,
            imageUrl: ""
        );

        if(imageFile!=null){
          UploadTask uploadTask = FirebaseStorage.instance.ref('book-pictures').child(newBookModel.uid.toString()).putFile(imageFile!);
          TaskSnapshot taskSnapshot = await uploadTask;

          String? imageUrl = await taskSnapshot.ref.getDownloadURL();

          // widget.userModel.profilepic = imageUrl;
          newBookModel.imageUrl = imageUrl;
        }
        else{
          log("Please upload an image of your book.");
        }

        CollectionReference booksCollection = FirebaseFirestore.instance.collection("books");
        await booksCollection.add(newBookModel.toMap());
        log("Book added Successfully");

        showDialog(context: context, builder: (BuildContext context){
          return AlertDialog(
            title: Text("Book sold Successfully."),
          );
        });
      }
      catch(e){
        log("Error adding Data: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sell Book"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              CupertinoButton(
                onPressed: (){showPhotoOptions();},
                child: CircleAvatar(
                  backgroundImage: (imageFile!=null)? FileImage(imageFile!) : null,
                  radius: 60,
                  child: (imageFile==null) ? const Icon(Icons.book, size: 70) : null,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: bookNameController,
                decoration: const InputDecoration(
                  labelText: "Enter Book Name",
                  icon: Icon(Icons.book)
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: bookEditionController,
                decoration: const InputDecoration(
                    labelText: "Enter Book Edition",
                    icon: Icon(Icons.book)
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: authorNameController,
                decoration: const InputDecoration(
                    labelText: "Enter Author Name",
                    icon: Icon(Icons.book)
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(
                    labelText: "Enter Book Price",
                    icon: Icon(Icons.currency_rupee)
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                    labelText: "Enter Description",
                    icon: Icon(Icons.description)
                ),
              ),
              const SizedBox(height: 20),
              // ElevatedButton(onPressed: (){showPhotoOptions();}, child: const Text("Pic of the Book.")),
              ElevatedButton(onPressed: (){sell();}, child: const Text("Sell Book"))
            ],
          ),
        ),
      ),
    );
  }
}
