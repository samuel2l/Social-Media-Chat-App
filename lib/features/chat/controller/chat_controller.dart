import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media_chat_app/features/auth/controller/auth_controller.dart';
import 'package:social_media_chat_app/features/chat/repository/chat_repository.dart';
import 'package:social_media_chat_app/features/common/enums/message_type.dart';
import 'package:social_media_chat_app/features/common/providers/reply_provider.dart';
import 'package:social_media_chat_app/models/chat_contact_model.dart';
import 'package:social_media_chat_app/models/message_model.dart';
import 'package:social_media_chat_app/models/user_model.dart';

final chatControllerProvider = Provider((ref) =>
    ChatController(chatRepository: ref.read(chatRepositoryProvider), ref: ref));

class ChatController {
  final ChatRepository chatRepository;
  final ProviderRef ref;
  ChatController({required this.chatRepository, required this.ref});

  void sendText({
    required BuildContext context,
    required String text,
    required String receiverUid,
  }) {
    //you can take the sender as a param which means logic will be in the uI
    //instead we use a ref to communicate with the auth provider to get the current user
    ref.read(getUserProvider).whenData((value) => chatRepository.sendText(
        context: context,
        text: text,
        receiverUid: receiverUid,
        sender: value!,
        reply: ref.read(replyProvider)));
  }

  Stream<List<ChatContact>> getChats() {
    return chatRepository.getChats();
  }

  Stream<List<Message>> getMessages(receiveruid) {
    return chatRepository.getMessages(receiveruid);
  }

  void sendFile({
    required BuildContext context,
    required File file,
    required UserModel receiver,
    required MessageType messageType,
  }) {
    ref.read(getUserProvider).whenData((value) => chatRepository.sendFile(
        context: context,
        file: file,
        receiver: receiver,
        sender: value!,
        ref: ref,
        messageType: messageType));
    ref.read(replyProvider.notifier).update((state) => null);
  }
  //   void sendGIF({
  //   required BuildContext context,
  //   required String gifURL,A very lo
  //     required String receiverUid,

  // }) {
  //   ref.read(getUserProvider).whenData((value) => chatRepository.sendGIF(context: context, gifURL: gifURL, receiverUid: receiverUid, sender: value!,reply:reply: ref.read(replyProvider)));
  // }
}
