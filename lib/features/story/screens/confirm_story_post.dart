import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media_chat_app/features/story/controller/story_controller.dart';
import 'package:social_media_chat_app/utils/colors.dart';

class ConfirmStoryPost extends ConsumerWidget {
  static const String routeName = '/confirm-story-post';
  final File file;
  final String caption;

  const ConfirmStoryPost( {super.key, required this.file,required this.caption,});
void uploadstory(WidgetRef ref,BuildContext context){
  ref.read(storyControllerProvider).uploadstory(post: file, context: context);
  Navigator.pop(context);
}
  @override

  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
          Text(caption),
          AspectRatio(
            aspectRatio: 9 / 16,
            child: Image.asset(file.path),

          ),

          ]
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            uploadstory(ref, context);
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
