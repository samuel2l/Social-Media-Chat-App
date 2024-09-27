import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media_chat_app/features/story/controller/story_controller.dart';
import 'package:social_media_chat_app/utils/colors.dart';

class ConfirmStoryPost extends ConsumerWidget {
  static const String routeName = '/confirm-story-post';
  final File file;

  const ConfirmStoryPost({super.key, required this.file});
  void uploadstory(WidgetRef ref, BuildContext context, caption) {
    ref
        .read(storyControllerProvider)
        .uploadstory(post: file, context: context, caption: caption ?? '');
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController captionController = TextEditingController();
    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          TextField(
            controller: captionController,
          ),
          Expanded(
            child: Image.asset(file.path),
          ),
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            uploadstory(ref, context, captionController.text.trim());
          },
          backgroundColor: tabColor,
          child: const Icon(
            Icons.done,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
