// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:social_media_chat_app/features/chat/controller/chat_controller.dart';
import 'package:social_media_chat_app/models/message_model.dart';
import 'package:social_media_chat_app/widgets/my_message_card.dart';
import 'package:social_media_chat_app/widgets/sender_message_card.dart';

class Messages extends ConsumerStatefulWidget {
  final String receiveruid;

  const Messages({super.key, required this.receiveruid});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MessagesState();
}

class _MessagesState extends ConsumerState<Messages> {
    final newMnessageController=ScrollController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Message>>(
        stream:
            ref.watch(chatControllerProvider).getMessages(widget.receiveruid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
            newMnessageController.jumpTo(newMnessageController.position.maxScrollExtent);
           });
          return ListView.builder(
            controller: newMnessageController,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var message=snapshot.data![index];
              if (message.senderUid==FirebaseAuth.instance.currentUser!.uid) {
                return MyMessageCard(
                  message: message.text,
                  date: DateFormat.Hm().format(message.timeSent),
                );
              }
              return SenderMessageCard(
                  message: message.text,
                  date: DateFormat.Hm().format(message.timeSent),
              );
            },
          );
        });
  }
}
