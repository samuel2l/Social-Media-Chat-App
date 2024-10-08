import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media_chat_app/features/auth/controller/auth_controller.dart';
import 'package:social_media_chat_app/features/story/repository/story_repository.dart';
import 'package:social_media_chat_app/models/story_model.dart';

final storyControllerProvider = Provider(
  (ref) {
    return StoryController(
        storyRepository: ref.read(storyRepositoryProvider), ref: ref);
  },
);

class StoryController {
  final StoryRepository storyRepository;
  final ProviderRef ref;

  StoryController({required this.storyRepository, required this.ref});

  void uploadstory({
    required File post,
    required String caption,
    required BuildContext context,
  }) {
    ref.read(getUserProvider).whenData((value) => storyRepository.uploadstory(
        name: value!.name,
        dp: value.dp,
        number: value.phoneNumber,
        post: post,
        context: context,
        caption: caption));
  }

  Future<List<Story>> getStories(BuildContext context)async{
    var stories=await storyRepository.getStories(context);
    return stories;
  }
}
