import 'package:flutter/material.dart';
import 'package:student_marketplace/models/bookModel.dart';

class BookDetailScreen extends StatelessWidget {
  final BookModel book;

  const BookDetailScreen({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Details"),
        backgroundColor: Colors.purple, // Set your preferred app bar color
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  book.imageUrl ?? '',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "Book Name",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              book.bookName ?? ' ',
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "Author",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              book.bookAuthor ?? ' ',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.blue, // Set your preferred text color
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "Edition",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              book.bookEdition ?? ' ',
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "Price",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Rs. ${book.bookPrice ?? ' '}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.green, // Set your preferred price color
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "Description",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              book.description ?? ' ',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}