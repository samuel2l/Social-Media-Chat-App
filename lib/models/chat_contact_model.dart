class ChatContact {
  final String name;
  final String dp;
final String uid;
final String lastMessage;
  final DateTime timeSent;

  ChatContact({required this.name, required this.dp, required this.uid, required this.lastMessage, required this.timeSent});





  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'dp': dp,
      'uid': uid,
      'lastMessage': lastMessage,
      'timeSent': timeSent.millisecondsSinceEpoch,
    };
  }

  factory ChatContact.fromMap(Map<String, dynamic> map) {
    return ChatContact(
      name: map['name'] as String,
      dp: map['dp'] as String,
      uid: map['uid'] as String,
      lastMessage: map['lastMessage'] as String,
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent'] as int),
    );
  }

}
