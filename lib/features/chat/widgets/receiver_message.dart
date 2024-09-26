import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media_chat_app/features/chat/widgets/message.dart';
import 'package:social_media_chat_app/features/common/enums/message_type.dart';

import 'package:social_media_chat_app/utils/colors.dart';
import 'package:swipe_to/swipe_to.dart';

class MyMessageCard extends ConsumerStatefulWidget {
  final String message;
  final String date;
  final MessageType messageType;
  final MessageType repliedMessageType;
  final String repliedMessageContent;
  final String username;
  final VoidCallback onSwipe;

  const MyMessageCard(
      {super.key,
      required this.message,
      required this.date,
      required this.messageType,
      required this.repliedMessageType,
      required this.repliedMessageContent,
      required this.username,
      required this.onSwipe});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyMessageCardState();
}

class _MyMessageCardState extends ConsumerState<MyMessageCard> {
  @override
  Widget build(BuildContext context) {
    return SwipeTo(
      onLeftSwipe: (details) {
        widget.onSwipe();
      },
      child: Align(
        alignment: Alignment.centerRight,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 45,
          ),
          child: Card(
            elevation: 1,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            color: messageColor,
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Stack(
              children: [
                Padding(
                  padding: widget.messageType == MessageType.text
                      ? const EdgeInsets.only(
                          left: 10,
                          right: 30,
                          top: 5,
                          bottom: 20,
                        )
                      : const EdgeInsets.only(
                          left: 5,
                          top: 5,
                          right: 5,
                          bottom: 25,
                        ),
                  child: Column(
                    children: [
                      // the spread operator) is used to insert multiple elements into a collection, such as a list, set, or map. This is particularly useful when you want to conditionally add items or merge multiple collections.
// Without the ... operator, you would get an error trying to insert a list where individual widgets are expected. It essentially unpacks the list into its components.
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
                  bottom: 4,
                  right: 10,
                  child: Row(
                    children: [
                      Text(
                        widget.date,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.white60,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(
                        Icons.done_all,
                        size: 20,
                        color: Colors.white60,
                      ),
                    ],
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
