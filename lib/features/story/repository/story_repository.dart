import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media_chat_app/features/common/repository/firebase_storage.dart';
import 'package:social_media_chat_app/features/common/utils/utils.dart';

import 'package:social_media_chat_app/models/story_model.dart';
import 'package:social_media_chat_app/models/user_model.dart';
import 'package:uuid/uuid.dart';

final storyRepositoryProvider = Provider(
  (ref) => StoryRepository(
    firestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
    ref: ref,
  ),
);

class StoryRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  final ProviderRef ref;
  StoryRepository({
    required this.firestore,
    required this.auth,
    required this.ref,
  });

  void uploadstory({
    required String name,
    required String dp,
    required String number,
    required File post,
    required BuildContext context,
  }) async {
    try {
      var storyId = const Uuid().v1();
      String uid = auth.currentUser!.uid;
      String imageurl = await ref
          .read(firebaseStorageRepositoryProvider)
          .storeFileToFirebase(
            '/story/$storyId$uid',
            post,
          );
      List<Contact> contacts = [];
      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(withProperties: true);
      }

      List<String> contactsStoryVisibleTo = [];

      for (int i = 0; i < contacts.length; i++) {
        var userDataFirebase = await firestore
            .collection('users')
            .where(
              'number',
              isEqualTo: contacts[i].phones[0].number.replaceAll(
                    ' ',
                    '',
                  ),
            )
            .get();

        if (userDataFirebase.docs.isNotEmpty) {
          var userData = UserModel.fromMap(userDataFirebase.docs[0].data());
          contactsStoryVisibleTo.add(userData.uid);
        }
      }

      List<String> postUrls = [];
      var storyesSnapshot = await firestore
          .collection('story')
          .where(
            'uid',
            isEqualTo: auth.currentUser!.uid,
          )
          .get();

      if (storyesSnapshot.docs.isNotEmpty) {
        Story story = Story.fromMap(storyesSnapshot.docs[0].data());
        postUrls = story.photoUrl;
        postUrls.add(imageurl);
        await firestore
            .collection('story')
            .doc(storyesSnapshot.docs[0].id)
            .update({
          'photoUrl': postUrls,
        });
        return;
      } else {
        postUrls = [imageurl];
      }

      Story story = Story(
        uid: uid,
        name: name,
        number: number,
        photoUrl: postUrls,
        createdAt: DateTime.now(),
        dp: dp,
        storyId: storyId,
        contactsStoryVisibleTo: contactsStoryVisibleTo,
      );

      await firestore.collection('story').doc(storyId).set(story.toMap());
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  Future<List<Story>> getstory(BuildContext context) async {
    List<Story> stories = [];
    try {
      List<Contact> contacts = [];
      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(withProperties: true);
      }
      for (int i = 0; i < contacts.length; i++) {
        var storyesSnapshot = await firestore
            .collection('story')
            .where(
              'number',
              isEqualTo: contacts[i].phones[0].number.replaceAll(
                    ' ',
                    '',
                  ),
            )
            .where(
              'createdAt',
              isGreaterThan: DateTime.now()
                  .subtract(const Duration(hours: 24))
                  .millisecondsSinceEpoch,
            )
            .get();
        for (var tempData in storyesSnapshot.docs) {
          Story tempstory = Story.fromMap(tempData.data());
          if (tempstory.contactsStoryVisibleTo.contains(auth.currentUser!.uid)) {
            stories.add(tempstory);
          }
        }
      }
    } catch (e) {
      // if (kDebugMode) print(e);
      showSnackBar(context: context, content: e.toString());
    }
    return stories;
  }
}