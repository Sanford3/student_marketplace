import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_marketplace/models/UserModel.dart';
import 'package:student_marketplace/models/messageModel.dart';
import 'package:student_marketplace/screens/chat_screen.dart';
import 'package:uuid/uuid.dart';

import '../models/bookModel.dart';
import '../models/chatroom.dart';
import '../models/firebaseHelper.dart';

class MessagesScreen extends StatefulWidget {
  final User firebaseUser;
  final UserModel userModel;
  final BookModel bookModel;
  const MessagesScreen({super.key, required this.firebaseUser, required this.userModel, required this.bookModel});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {

  void chatWithSeller(String sellerId) async{

    // check if chatroom already exists.
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("chatrooms")
        .where("participants.${widget.firebaseUser.uid}", isEqualTo: true)
        .where("participants.$sellerId", isEqualTo: true)
        .get();

    log(querySnapshot.docs.length.toString());
    ChatRoomModel chatRoomModel;
    if(querySnapshot.docs.isEmpty){
      var uuid = const Uuid();

      // create a chatroom if not.
      chatRoomModel = ChatRoomModel(
          chatroomid: "",
          participants: {
            widget.firebaseUser.uid: true,
            sellerId: true
          },
          lastMessage: ""
      );
      // Reference to the chatroom document in the "chatrooms" collection
      DocumentReference docRef = await FirebaseFirestore.instance.collection("chatrooms").add(chatRoomModel!.toMap());

      // Retrieve the generated ID and update the chatroomid field
      chatRoomModel.chatroomid = docRef.id;

      // Now, you can update the document with the correct chatroomid
      await docRef.update({"chatroomid": chatRoomModel.chatroomid});
    }
    else {
      // Use data() to get the document data as Map<String, dynamic>
      Map<String, dynamic>? data = querySnapshot.docs[0].data() as Map<String, dynamic>?;

      if (data != null) {
        // Handle the case where data is not null
        chatRoomModel = ChatRoomModel.fromMap(data);
      } else {
        // Handle the case where data is null (optional, depending on your use case)
        chatRoomModel = ChatRoomModel(chatroomid: "", participants: {}, lastMessage: "");
      }
    }
    Navigator.push(context, MaterialPageRoute(builder: (context)=> ChatRoomScreen(firebaseUser: widget.firebaseUser, userModel: widget.userModel, bookModel: widget.bookModel, chatRoomModel: chatRoomModel!)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Messages"),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(
        child: Container(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("chatrooms")
                .where("participants.${widget.userModel.uid}", isEqualTo: true)
                .snapshots(),
            builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.active){
                if(snapshot.hasData){
                  QuerySnapshot chatRooms = snapshot.data as QuerySnapshot;

                  return ListView.builder(
                      itemCount: chatRooms.docs.length,
                      itemBuilder: (context, index){
                        ChatRoomModel chatRoomModel = ChatRoomModel.fromMap(chatRooms.docs[index].data() as Map<String, dynamic>);

                        Map<String, dynamic> participants = chatRoomModel.participants!;
                        List<String> participantsKeys = participants.keys.toList();
                        participantsKeys.remove(widget.userModel.uid);

                        return FutureBuilder(
                            future: FirebaseHelper.getUserModel(participantsKeys[0]),
                            builder: (context, userData) {
                              if(userData.connectionState == ConnectionState.done){
                                if(userData.data != null){
                                  UserModel targetUser = userData.data as UserModel;
                                  log(chatRoomModel.lastMessage.toString());
                                  return ListTile(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context){
                                            return ChatRoomScreen(
                                                bookModel: widget.bookModel,
                                                chatRoomModel: chatRoomModel,
                                                userModel: widget.userModel,
                                                firebaseUser: widget.firebaseUser
                                            );
                                          })
                                      );
                                    }, // onTap
                                    title: Text("Buyer ${index+1}"),
                                    subtitle: (chatRoomModel.lastMessage.toString() != "")
                                        ? Text(chatRoomModel.lastMessage.toString())
                                        : Text(
                                      "Say hi to your new friend!",
                                      style: TextStyle(
                                        color: Theme.of(context).colorScheme.secondary,
                                      ),
                                    ),
                                  );
                                }
                                else if(userData.hasError){
                                  return Center(
                                    child: Text(snapshot.error.toString()),
                                  );
                                }
                                else{
                                  return Center(
                                    child: Container(
                                        child: Text("No Chats.")
                                    ),
                                  );
                                }
                              }
                              else{
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            }
                        );
                      }
                  );
                }
                else if(snapshot.hasError){
                  return Center(
                    child: Text("An Error Occurred"),
                  );
                }
                else{
                  return Center(
                    child: Text("Connection Lost"),
                  );
                }
              }
              else{
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
