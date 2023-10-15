import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {

  String? chatroom;
  String? messageId;
  String? sender;
  String? text;
  bool? seen;
  DateTime? createdOn;

  MessageModel({this.chatroom, this.messageId, this.sender, this.seen, this.createdOn, this.text});

  MessageModel.fromMap(Map<String, dynamic> map) {
    chatroom = map["chatroom"];
    sender = map["sender"];
    seen = map["seen"];
    text = map["text"];
    createdOn = (map["createdOn"] as Timestamp).toDate();
    messageId = map["messageid"];
  }

  Map<String, dynamic> toMap() {
    return{
      "chatroom" : chatroom,
      "sender" : sender,
      "text" : text,
      "seen" : seen,
      "createdOn" : createdOn,
      "messageid" : messageId
    };
  }

}