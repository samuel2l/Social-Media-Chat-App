import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_chat_app/features/common/utils/utils.dart';
import 'package:social_media_chat_app/models/chat_contact_model.dart';
import 'package:social_media_chat_app/models/user_model.dart';

class ChatRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  ChatRepository({required this.auth, required this.firestore});

  void saveChatDataToContactCollection(
      {required UserModel sender,
      required UserModel receiver,
      required String text,
      required DateTime timeSent}) async {
    var receiverChatContact = ChatContact(
        name: sender.name,
        dp: sender.dp,
        uid: sender.uid,
        lastMessage: text,
        timeSent: timeSent);
    await firestore
        .collection('users')
        .doc(receiver.uid)
        .collection('chats')
        .doc(sender.uid)
        .set(receiverChatContact.toMap());
    var senderChatContact = ChatContact(
        name: receiver.name,
        dp: receiver.dp,
        uid: receiver.uid,
        lastMessage: text,
        timeSent: timeSent);
    await firestore
        .collection('users')
        .doc(sender.uid)
        .collection('chats')
        .doc(receiver.uid)
        .set(senderChatContact.toMap());
  }

  void saveMessage(
      {required UserModel sender,
      required UserModel receiver,
      required String text,
      required DateTime timeSent,
      required String messageId}) {}

  void sendText(
      {required BuildContext context,
      required String text,
      required String receiverUid,
      required UserModel sender}) async {
    try {
      var timeSent = DateTime.now();
      UserModel receiver;
      var userDataMap =
          await firestore.collection('users').doc(receiverUid).get();
      receiver = UserModel.fromMap(userDataMap.data()!);
      saveChatDataToContactCollection(
          sender: sender, receiver: receiver, text: text, timeSent: timeSent);
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}
