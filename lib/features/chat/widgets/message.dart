import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_media_chat_app/features/common/enums/message_type.dart';

class Message extends StatelessWidget {
  const Message({super.key, required this.message, required this.messageType});
final String message;
final MessageType messageType;
  @override
  Widget build(BuildContext context) {
    return messageType==MessageType.text?Text(
                  message,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ):CachedNetworkImage(imageUrl: message)
    ;
  }
}