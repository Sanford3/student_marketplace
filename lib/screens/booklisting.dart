import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_marketplace/models/bookModel.dart';
import 'package:student_marketplace/screens/bookDetails.dart';
import 'package:student_marketplace/screens/book_selling.dart';
import '../models/UserModel.dart';
import 'chat_screen.dart';

class BookListingScreen extends StatefulWidget {
  final BookModel bookModel;
  final UserModel userModel;
  final User firebaseUser;
  final int semester;

  const BookListingScreen({
    Key? key,
    required this.bookModel,
    required this.userModel,
    required this.firebaseUser, required this.semester,
  }) : super(key: key);

  @override
  State<BookListingScreen> createState() => _BookListingScreenState();
}

class _BookListingScreenState extends State<BookListingScreen> {
  late Future<List<BookModel>> _books;

  @override
  void initState() {
    super.initState();
    _books = listBooks();
  }

  Future<List<BookModel>> listBooks() async {
    CollectionReference collectionReference =
    FirebaseFirestore.instance.collection("books");
    List<BookModel> books = [];

    QuerySnapshot querySnapshot = await collectionReference
        .where("subjectname", isEqualTo: widget.bookModel.subjectName)
        .where("department", isEqualTo: widget.bookModel.department)
        .where("semester", isEqualTo: widget.semester)
        .get();

    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      BookModel book = BookModel.fromMap(doc.data() as Map<String, dynamic>);
      books.add(book);
    }

    return books;
  }

  void deleteBook (String bookId) async {

    CollectionReference collectionReference = FirebaseFirestore.instance.collection("books");
    QuerySnapshot querySnapshot = await collectionReference.where("uid", isEqualTo: bookId).get();

    if(querySnapshot.docs.isNotEmpty){
      DocumentSnapshot documentSnapshot = querySnapshot.docs[0];

      // Get the reference to the document
      DocumentReference documentReference = documentSnapshot.reference;

      // Delete the document
      await documentReference.delete();
      log("Book Deleted Successfully");

      showDialog(context: context, builder: (BuildContext context){
        return AlertDialog(
          title: Text("Book Deleted Successfully."),
        );
      });
    }
    else{
      log("No Document Found.");
    }
  }

  void chatWithSeller(){

    Navigator.push(context, MaterialPageRoute(builder: (context)=> ChatRoomScreen(firebaseUser: widget.firebaseUser, userModel: widget.userModel, bookModel: widget.bookModel)));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Books List"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: _books,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Error displaying data: ${snapshot.error}",
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      "No Books yet.",
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      BookModel book = snapshot.data![index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    BookDetailScreen(book: book)),
                          );
                        },
                        child: Card(
                          elevation: 3,
                          margin: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              AspectRatio(
                                aspectRatio: 16 / 9,
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage("${book.imageUrl}"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Book Name: ${book.bookName ?? ' '}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      "Price: ${book.bookPrice ?? ' '}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      widget.firebaseUser.uid == book.sellerId ?
                                          deleteBook(book.uid.toString())
                                          :
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=> ChatRoomScreen(firebaseUser: widget.firebaseUser, userModel: widget.userModel, bookModel: widget.bookModel)));
                                    },
                                    child: widget.firebaseUser.uid == book.sellerId ? const Text("Delete Book") : const Text("Chat with Seller.")
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookSellingScreen(
                      bookModel: widget.bookModel,
                      firebaseUser: widget.firebaseUser,
                      userModel: widget.userModel,
                      semester: widget.semester
                    ),
                  ),
                );
              },
              child: const Text(
                "Sell a Book",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*

  void deleteBook (String bookId) async {

    CollectionReference collectionReference = FirebaseFirestore.instance.collection("books");
    QuerySnapshot querySnapshot = await collectionReference.where("uid", isEqualTo: bookId).get();

    if(querySnapshot.docs.isNotEmpty){
      DocumentSnapshot documentSnapshot = querySnapshot.docs[0];

      // Get the reference to the document
      DocumentReference documentReference = documentSnapshot.reference;

      // Delete the document
      await documentReference.delete();
      log("Book Deleted Successfully");
      setState(() {});
    }
    else{
     log("No Document Found.");
    }
  }

  void chatWithSeller(){

    Navigator.push(context, MaterialPageRoute(builder: (context)=> ChatRoomScreen(firebaseUser: widget.firebaseUser, userModel: widget.userModel, bookModel: widget.bookModel)));

  }
 */