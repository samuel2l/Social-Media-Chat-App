class Story {
  final String uid;
  final String name;
  final String number;
  final List<String> photoUrl;
  final DateTime createdAt;
  final String dp;
  final String storyId;
  final String caption;
  final List<String> contactsStoryVisibleTo;
  Story({
    required this.uid,
    required this.name,
    required this.number,
    required this.photoUrl,
    required this.createdAt,
    required this.dp,
    required this.storyId,
    required this.contactsStoryVisibleTo,
        required this.caption,

  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'number': number,
      'photoUrl': photoUrl,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'dp': dp,
      'storyId': storyId,
      'contactsStoryVisibleTo': contactsStoryVisibleTo,
      'caption':caption
    };
  }

  factory Story.fromMap(Map<String, dynamic> map) {
    return Story(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      number: map['number'] ?? '',
      photoUrl: List<String>.from(map['photoUrl']),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      dp: map['dp'] ?? '',
      storyId: map['storyId'] ?? '',
      contactsStoryVisibleTo: List<String>.from(map['contactsStoryVisibleTo']),
      caption: map['caption'] ?? '',
    );
  }
}