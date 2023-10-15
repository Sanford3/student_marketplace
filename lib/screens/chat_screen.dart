import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_marketplace/models/UserModel.dart';
import 'package:student_marketplace/models/bookModel.dart';
import 'package:student_marketplace/models/chatroom.dart';
import 'package:student_marketplace/models/messageModel.dart';
import 'package:uuid/uuid.dart';

class ChatRoomScreen extends StatefulWidget {
  final User firebaseUser;
  final UserModel userModel;
  final BookModel bookModel;
  final ChatRoomModel chatRoomModel;
  const ChatRoomScreen({super.key, required this.firebaseUser, required this.userModel, required this.bookModel, required this.chatRoomModel});

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {

  TextEditingController messageController = TextEditingController();

  void sendMessage () {

    String message = messageController.text.trim();

    var uuid = const Uuid();
    MessageModel messageModel = MessageModel(
      chatroom: widget.chatRoomModel.chatroomid,
      messageId: uuid.v1(),
      sender: widget.firebaseUser.uid,
      seen: false,
      text: message,
      createdOn: DateTime.now()
    );

    widget.chatRoomModel.lastMessage=message;
    FirebaseFirestore.instance.collection("chatrooms")
    .doc(widget.chatRoomModel.chatroomid)
    .set(widget.chatRoomModel.toMap());

    FirebaseFirestore.instance.collection("chatrooms")
        .doc(widget.chatRoomModel.chatroomid)
        .collection("messages")
        .doc(messageModel.messageId)
        .set(messageModel.toMap());

    log("Message sent.");
    messageController.clear();
  }

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
              Expanded(
                  child: Container(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance.collection("chatrooms")
                          .doc(widget.chatRoomModel.chatroomid)
                          .collection("messages")
                          .orderBy("createdOn", descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if(snapshot.connectionState==ConnectionState.active){
                          if(snapshot.hasData){

                            QuerySnapshot querySnapshot = snapshot.data as QuerySnapshot;
                            return ListView.builder(

                                reverse: true,
                                itemCount: querySnapshot.docs.length,
                                itemBuilder: (context, index){
                                  MessageModel currentMsg = MessageModel.fromMap(querySnapshot.docs[index].data() as Map<String, dynamic>);
                                  return Row(
                                    mainAxisAlignment: (currentMsg.sender==widget.userModel.uid)? MainAxisAlignment.end : MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          margin: const EdgeInsets.symmetric(vertical: 2),
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                          decoration: BoxDecoration(
                                              color: (currentMsg.sender==widget.userModel.uid)? Colors.grey : Theme.of(context).primaryColor,
                                              borderRadius: BorderRadius.circular(5)
                                          ),
                                          child: Text(currentMsg.text.toString(), style: TextStyle(color: (currentMsg.sender==widget.userModel.uid)? Colors.white : Colors.grey))
                                      ),
                                    ],
                                  );
                                });
                          }
                          else if(snapshot.hasError){
                            return const Center(
                              child: Text("An error Occurred. Please check your Internet Connection."),
                            );
                          }
                          else{
                            return const Center(
                              child: Text("Say Hello To your Friend!"),
                            );
                          }
                        }
                        else{
                          return const Center(
                              child: CircularProgressIndicator()
                          );
                        }
                      },
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
                        onPressed: (){sendMessage();},
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
