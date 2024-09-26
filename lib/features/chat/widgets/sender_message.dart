import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media_chat_app/features/chat/widgets/message.dart';
import 'package:social_media_chat_app/features/common/enums/message_type.dart';
import 'package:social_media_chat_app/utils/colors.dart';
import 'package:swipe_to/swipe_to.dart';

class SenderMessageCard extends ConsumerStatefulWidget {
  const SenderMessageCard({
    super.key,
    required this.message,
    required this.date,
    required this.messageType,
    required this.repliedMessageType,
    required this.repliedMessageContent,
    required this.username,
    required this.onSwipe,
  });
  final String message;
  final String date;
  final MessageType messageType;
  final MessageType repliedMessageType;
  final String repliedMessageContent;
  final String username;
  final VoidCallback onSwipe;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SenderMessageCardState();
}

class _SenderMessageCardState extends ConsumerState<SenderMessageCard> {
  @override
  Widget build(BuildContext context) {
    return SwipeTo(
      onRightSwipe: (details) {
        widget.onSwipe();
      },
      child: Align(
        alignment: Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 45,
          ),
          child: Card(
            elevation: 1,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            color: senderMessageColor,
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 30,
                    top: 5,
                    bottom: 20,
                  ),
                  child: Column(
                    children: [
                      if (widget.repliedMessageContent.isNotEmpty) ...[
                        Text(
                          widget.username,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: backgroundColor.withOpacity(0.5),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(
                                  5,
                                ),
                              ),
                            ),
                            child: Message(
                                message: widget.repliedMessageContent,
                                messageType: widget.repliedMessageType)),
                        const SizedBox(height: 8),
                      ],
                      Message(
                        message: widget.message,
                        messageType: widget.messageType,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 2,
                  right: 10,
                  child: Text(
                    widget.date,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
