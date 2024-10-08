import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:social_media_chat_app/features/chat/controller/chat_controller.dart';
import 'package:social_media_chat_app/features/chat/widgets/reply_header.dart';
import 'package:social_media_chat_app/features/common/enums/message_type.dart';
import 'package:social_media_chat_app/features/common/providers/reply_provider.dart';
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
  FlutterSoundRecorder? soundRecorder;
  bool isRecorderInit = false;
  bool isAudio = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    soundRecorder = FlutterSoundRecorder();
    openAudio();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    messageController.dispose();
    soundRecorder!.closeRecorder();
    isRecorderInit = false;
    super.dispose();
  }

  void openAudio() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Mic permission not allowed!');
    }
    await soundRecorder!.openRecorder();
    isRecorderInit = true;
  }

  void sendText() async {
    if (isMessage) {
      ref.read(chatControllerProvider).sendText(
          context: context,
          text: messageController.text.trim(),
          receiverUid: widget.receiverUid);
      setState(() {
        messageController.text = '';
      });
    } else {
      var tempDir = await getTemporaryDirectory();
      var path = '${tempDir.path}/flutter_sound.aac';
      if (!isRecorderInit) {
        return;
      }
      //if you were recording message and then hit the send button

      if (isAudio) {
        await soundRecorder!.stopRecorder();
        sendFile(File(path), MessageType.audio);
      } else {
        await soundRecorder!.startRecorder(
          toFile: path,
        );
      }

      setState(() {
        isAudio = !isAudio;
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

// void sendGIF() async {
//     final gif = await pickGIF(context);
//     if (gif != null) {
//       ref.read(chatControllerProvider).sendGIF(context: context, gifURL: gif.url, receiverUid: widget.receiverUid);
//     }
//   }

  @override
  Widget build(BuildContext context) {
    final reply = ref.watch(replyProvider);
    print('reply ');
    print(reply);
    final isReply = reply != null;
    return SafeArea(
      child: Column(
        children: [
          // wrap the send message field with a column so the container for emojis can be displayed below it when tapped
          isReply ? const ReplyHeader() : const SizedBox(),
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
                      onLongPress: () {
                        if (!isMessage) {
                          sendText();
                        }
                      },
                      onTap: () {
                        sendText();
                      },
                      child: Icon(isMessage
                          ? Icons.send
                          : isAudio
                              ? Icons.close
                              : Icons.mic)),
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
