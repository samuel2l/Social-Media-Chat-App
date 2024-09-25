import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media_chat_app/features/common/enums/message_type.dart';

class Reply {
  final String message;
  final bool isMe;
  final MessageType messageType;

  Reply(this.message, this.isMe, this.messageType);
}

final replyProvider = StateProvider<Reply?>((ref) => null);