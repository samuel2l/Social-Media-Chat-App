import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media_chat_app/features/common/enums/message_type.dart';
import 'package:social_media_chat_app/features/common/utils/utils.dart';
import 'package:social_media_chat_app/models/chat_contact_model.dart';
import 'package:social_media_chat_app/models/message_model.dart';
import 'package:social_media_chat_app/models/user_model.dart';
import 'package:uuid/uuid.dart';

final chatRepositoryProvider = Provider(
  (ref) => ChatRepository(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  ),
);

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

  void saveMessage({
    required UserModel sender,
    required UserModel receiver,
    required String text,
    required DateTime timeSent,
    required String messageId,
    required MessageType messageType,
  }) async {
    final message = Message(
        senderUid: sender.uid,
        receiverUid: receiver.uid,
        text: text,
        messageType: messageType,
        timeSent: timeSent,
        messageId: messageId,
        isSeen: false);

    await firestore
        .collection('users')
        .doc(sender.uid)
        .collection('chats')
        .doc(receiver.uid)
        .collection('messages')
        .doc(messageId)
        .set(
          message.toMap(),
        );

    await firestore
        .collection('users')
        .doc(receiver.uid)
        .collection('chats')
        .doc(sender.uid)
        .collection('messages')
        .doc(messageId)
        .set(
          message.toMap(),
        );
  }

  void sendText(
      {required BuildContext context,
      required String text,
      required String receiverUid,
      required UserModel sender}) async {
    try {
      var timeSent = DateTime.now();
      var messageId = const Uuid().v1();
      UserModel receiver;
      var userDataMap =
          await firestore.collection('users').doc(receiverUid).get();
      receiver = UserModel.fromMap(userDataMap.data()!);

      saveChatDataToContactCollection(
          sender: sender, receiver: receiver, text: text, timeSent: timeSent);
      saveMessage(
          sender: sender,
          receiver: receiver,
          text: text,
          timeSent: timeSent,
          messageId: messageId,
          messageType: MessageType.text);
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
Stream<List<ChatContact>> getChats(){

    return firestore
        .collection('users')
        // auth.currentUser!.uid is same as sender.uid
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .snapshots()
        .asyncMap((event) async {
          // asyncMap: The stream of snapshots is transformed using asyncMap, which allows asynchronous operations on each snapshot event.
      List<ChatContact> contacts = [];
      for (var chatContactMap in event.docs) {
        var chatContact = ChatContact.fromMap(chatContactMap.data());
        var userData = await firestore
            .collection('users')
            .doc(chatContact.uid)
            .get();
        var user = UserModel.fromMap(userData.data()!);

        contacts.add(
          ChatContact(
            name: user.name,
            dp: user.dp,
            uid: chatContact.uid,
            timeSent: chatContact.timeSent,
            lastMessage: chatContact.lastMessage,
          ),
        );
      }
      return contacts;
    });
 
}

}
