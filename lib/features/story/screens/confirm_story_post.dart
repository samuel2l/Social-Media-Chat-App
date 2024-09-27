import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media_chat_app/utils/colors.dart';

class ConfirmStoryPost extends ConsumerWidget {
  static const String routeName = '/confirm-story-post';
  final File file;

  const ConfirmStoryPost({super.key, required this.file});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        body: AspectRatio(
          aspectRatio: 9 / 16,
          child: Image.asset(file.path),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
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
