import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Story extends ConsumerStatefulWidget {
    static const String routeName = '/stories';

  const Story({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StoryState();
}

class _StoryState extends ConsumerState<Story> {

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}