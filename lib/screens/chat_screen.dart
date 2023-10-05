import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_marketplace/models/UserModel.dart';
import 'package:student_marketplace/models/bookModel.dart';

class ChatRoomScreen extends StatefulWidget {
  final User firebaseUser;
  final UserModel userModel;
  final BookModel bookModel;
  const ChatRoomScreen({super.key, required this.firebaseUser, required this.userModel, required this.bookModel});

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {

  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.bookModel.sellerName.toString()),
        centerTitle: true,
        actions: [
          ElevatedButton(onPressed: (){}, child: const Icon(Icons.logout_outlined))
        ],
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(child:
                  Container(
                    child: const Center(
                        child: Text("No messages yet.")
                    ),
                  )
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Row(
                  children: [
                    Flexible(
                        child: TextField(
                          maxLines: null,
                          controller: messageController,
                          decoration: const InputDecoration(
                              hintText: "Enter a message",
                              border: InputBorder.none
                          ),
                        )
                    ),
                    // Icon(Icons.send_sharp, color: Theme.of(context).colorScheme.secondary),
                    IconButton(
                        onPressed: (){},
                        icon: const Icon(Icons.send_sharp))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
