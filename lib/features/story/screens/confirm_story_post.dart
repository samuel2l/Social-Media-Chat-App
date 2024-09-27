import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConfirmStoryPost extends ConsumerWidget {
  static const String routeName = '/confirm-story-post';
  final File file;

  const ConfirmStoryPost({super.key, required this.file});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        body: Image.asset(file.path),
      ),
    );
  }
}
