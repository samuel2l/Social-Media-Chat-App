import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media_chat_app/features/auth/controller/auth_controller.dart';
import 'package:social_media_chat_app/features/chat/repository/chat_repository.dart';
final chatControllerProvider=Provider((ref) => ChatController(chatRepository: ref.read(chatRepositoryProvider), ref: ref));
class ChatController{
  final ChatRepository chatRepository;
final ProviderRef ref;
  ChatController({required this.chatRepository,required this.ref});

  void sendText(
      {required BuildContext context,
      required String text,
      required String receiverUid,
 }){
  //you can take the sender as a param which means logic will be in the uI
  //instead we use a ref to communicate with the auth provider to get the current user
ref.read(getUserProvider).whenData((value)=>chatRepository.sendText(context: context, text: text, receiverUid: receiverUid, sender: value!));

      }
}