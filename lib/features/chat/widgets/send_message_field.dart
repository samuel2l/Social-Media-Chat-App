import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media_chat_app/features/chat/controller/chat_controller.dart';
import 'package:social_media_chat_app/features/common/enums/message_type.dart';
import 'package:social_media_chat_app/features/common/utils/utils.dart';
import 'package:social_media_chat_app/models/user_model.dart';
import 'package:social_media_chat_app/utils/colors.dart';

class SendMessageField extends ConsumerStatefulWidget {
  final String receiverUid;
  const SendMessageField({super.key, required this.receiverUid});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SendMessageFieldState();
}

class _SendMessageFieldState extends ConsumerState<SendMessageField> {
  var isMessage = false;
  var messageController = TextEditingController();
  bool isEmojiSelected = false;
  FocusNode focusNode = FocusNode();
  void sendText() {
    if (isMessage) {
      ref.read(chatControllerProvider).sendText(
          context: context,
          text: messageController.text.trim(),
          receiverUid: widget.receiverUid);
      setState(() {
        messageController.text = '';
      });
    }
  }

  void sendFile(
    File file,
    MessageType messageType,
  ) async {
    var userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.receiverUid)
        .get();
    UserModel? receiver;
    if (userData.data() != null) {
      receiver = UserModel.fromMap(userData.data()!);
    }
    ref.read(chatControllerProvider).sendFile(
        context: context,
        file: file,
        receiver: receiver!,
        messageType: messageType);
  }

  void sendImage() async {
    File? image = await pickImageFromGallery(context);
    if (image != null) {
      sendFile(image, MessageType.image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // wrap the send message field with a column so the container for emojis can be displayed below it when tapped
          Row(
            children: [
              Expanded(
                flex: 6,
                child: TextField(
                  focusNode: focusNode,
                  controller: messageController,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      setState(() {
                        isMessage = true;
                      });
                    } else {
                      setState(() {
                        isMessage = false;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: mobileChatBoxColor,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 13),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.13,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                isEmojiSelected == true
                                    ? isEmojiSelected = false
                                    : isEmojiSelected = true;
                                isEmojiSelected == false
                                    ? focusNode.requestFocus()
                                    : focusNode.unfocus();
                                // unfocus hides keyboard and .requestfocus shows keyboard
                                setState(() {});
                              },
                              child: isEmojiSelected
                                  ? const Icon(
                                      Icons.keyboard,
                                      color: Colors.grey,
                                    )
                                  : const Icon(
                                      Icons.emoji_emotions,
                                      color: Colors.grey,
                                    ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: const Icon(
                                Icons.gif,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    suffixIcon: SizedBox(
                      width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.grey,
                            ),
                            onTap: () {
                              sendImage();
                            },
                          ),
                          GestureDetector(
                            child: const Icon(
                              Icons.attach_file,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    hintText: 'Type a message!',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(10),
                  ),
                ),
              ),
              Expanded(
                child: CircleAvatar(
                  backgroundColor: tabColor,
                  child: GestureDetector(
                      onTap: () {
                        sendText();
                      },
                      child: Icon(isMessage ? Icons.send : Icons.mic)),
                ),
              )
            ],
          ),
          isEmojiSelected
              ? SizedBox(
                  child: EmojiPicker(
                    onEmojiSelected: (category, emoji) {
                      if (isEmojiSelected == true) {
                        setState(() {
                          messageController.text =
                              messageController.text + emoji.emoji;
                          
                        });
                      }
                    },
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
