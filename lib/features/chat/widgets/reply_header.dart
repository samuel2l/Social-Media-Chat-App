import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media_chat_app/features/common/providers/reply_provider.dart';

class ReplyHeader extends ConsumerWidget {
  const ReplyHeader({super.key});

  void cancelReply(WidgetRef ref) {
 ref.read(replyProvider.notifier).update((state) => null);

   }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reply = ref.watch(replyProvider);

    return Container(
      width: 350,
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  reply!.isMe ? 'Me' : 'Opposite',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GestureDetector(
                child: const Icon(
                  Icons.close,
                  size: 16,
                ),
                onTap: () => cancelReply(ref),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // DisplayTextImageGIF(
          //   message: reply.message,
          //   type: reply.messageTyoe,
          // ),
        ],
      ),
    );
  }
}