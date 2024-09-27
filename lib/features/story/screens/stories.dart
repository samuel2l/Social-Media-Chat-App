import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Stories extends ConsumerStatefulWidget {
    static const String routeName = '/stories';

  const Stories({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StoriesState();
}

class _StoriesState extends ConsumerState<Stories> {

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}