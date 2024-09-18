import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media_chat_app/features/auth/controller/auth_controller.dart';
import 'package:social_media_chat_app/models/user_model.dart';
import 'package:social_media_chat_app/utils/colors.dart';
import 'package:social_media_chat_app/widgets/chat_list.dart';

class MobileChatScreen extends ConsumerStatefulWidget {

  static const String routeName = '/chat-screen';

  final String name, uid;

  const MobileChatScreen({super.key, required this.name, required this.uid});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MobileChatScreenState();
}

class _MobileChatScreenState extends ConsumerState<MobileChatScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: StreamBuilder<UserModel>(
          stream: ref.watch(authControllerProvider).checkUserOnline(widget.uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              children: [
                Text(widget.name),
                Text(
                  snapshot.data!.isOnline ? 'online' : 'offline',
                  style: const TextStyle(fontSize: 15),
                )
              ],
            );
          },
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.video_call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Column(
        children: [
          const Expanded(
            child: ChatList(),
          ),
          Row(
            children: [
              Expanded(
                flex: 6,
                child: TextField(
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
                              onTap: () {},
                              child: const Icon(
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
                    suffixIcon: const SizedBox(
                      width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.camera_alt,
                            color: Colors.grey,
                          ),
                          Icon(
                            Icons.attach_file,
                            color: Colors.grey,
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
              const Expanded(
                child: CircleAvatar(
                  backgroundColor: tabColor,
                  child: Icon(Icons.send),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}