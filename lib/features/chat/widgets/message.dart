import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_media_chat_app/features/common/enums/message_type.dart';

class Message extends StatelessWidget {
  const Message({
    super.key,
    required this.message,
    required this.messageType,
  });

  final String message;
  final MessageType messageType;

  @override
  Widget build(BuildContext context) {
    final AudioPlayer audioPlayer = AudioPlayer();
    bool isPlaying = false;
    

    return messageType == MessageType.text
        ? Text(
            message,
            style: const TextStyle(
              fontSize: 16,
            ),
          )
        : messageType == MessageType.image
            ? CachedNetworkImage(imageUrl: message)
            : messageType == MessageType.audio
                ? StatefulBuilder(builder: (context, setState) {
                    return IconButton(
                      constraints: const BoxConstraints(
                        minWidth: 100,
                      ),
                      onPressed: () async {
                        if (isPlaying) {
                          await audioPlayer.pause();
                          setState(() {
                            isPlaying = false;
                          });
                        } else {
                          await audioPlayer.play(UrlSource(message));
                          setState(() {
                            isPlaying = true;
                          });
                        }
                        
                      },
                      icon: Icon(
                        isPlaying ? Icons.pause_circle : Icons.play_circle,
                      ),
                    );
                  })
                : const SizedBox.shrink(); // Return an empty widget for other message types
  }
}
