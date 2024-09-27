import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media_chat_app/features/story/controller/story_controller.dart';
import 'package:social_media_chat_app/models/story_model.dart';
import 'package:social_media_chat_app/utils/colors.dart';

class Stories extends ConsumerStatefulWidget {
    static const String routeName = '/stories';

  const Stories({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StoriesState();
}

class _StoriesState extends ConsumerState<Stories> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Story>>(
      future: ref.read(storyControllerProvider).getStories(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(),);
        }
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            var story = snapshot.data![index];
            return Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      Stories.routeName,
                      arguments: story,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ListTile(
                      title: Text(
                        story.name,
                      ),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          story.dp,
                        ),
                        radius: 30,
                      ),
                    ),
                  ),
                ),
                const Divider(color: dividerColor, indent: 85),
              ],
            );
          },
        );
      },
    );
  }
}