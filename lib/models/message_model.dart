// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:social_media_chat_app/features/common/enums/message_type.dart';

class Message {
 final String senderUid;
 final String receiverUid;
 final String text;
 final MessageType messageType;
 final DateTime timeSent;
 final String messageId;
final bool isSeen;
  Message({required this.senderUid, required this.receiverUid, required this.text, required this.messageType, required this.timeSent,required this.messageId,required this.isSeen});  


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderUid': senderUid,
      'receiverUid': receiverUid,
      'text': text,
      'messageType': messageType.type,
      //line abv is why we used enhanced enums
      'timeSent': timeSent.millisecondsSinceEpoch,
      'messageId': messageId,
      'isSeen': isSeen,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      senderUid: map['senderUid'] as String,
      receiverUid: map['receiverUid'] as String,
      text: map['text'] as String,
      messageType: (map['messageType'] as String).toEnum(),
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent'] as int),
      messageId: map['messageId'] as String,
      isSeen: map['isSeen'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) => Message.fromMap(json.decode(source) as Map<String, dynamic>);
}
