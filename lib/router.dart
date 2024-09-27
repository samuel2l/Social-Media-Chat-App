import 'dart:io';

import 'package:flutter/material.dart';
import 'package:social_media_chat_app/features/auth/screens/login.dart';
import 'package:social_media_chat_app/features/auth/screens/otp.dart';
import 'package:social_media_chat_app/features/auth/screens/user_profile.dart';
import 'package:social_media_chat_app/features/contacts/screens/contacts.dart';
import 'package:social_media_chat_app/features/chat/screens/chat_screen.dart';
import 'package:social_media_chat_app/features/story/screens/confirm_story_post.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );

    case OTP.routeName:
      final String verificationId = settings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => OTP(
          verificationId: verificationId,
        ),
      );
    case UserProfileScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const UserProfileScreen(),
      );
    case ContactsScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const ContactsScreen(),
      );
    case MobileChatScreen.routeName:
          final args = settings.arguments as Map<String,dynamic>;
          final name=args['name'];
          final uid=args['uid'];


      return MaterialPageRoute(
        builder: (context) => MobileChatScreen(name: name, uid: uid,),
      );
          case ConfirmStoryPost.routeName:
          final file = settings.arguments as File;
          


      return MaterialPageRoute(
        builder: (context) => ConfirmStoryPost(file: file),
      );

    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: Center(
            child: Text('This page does not exist'),
          ),
        ),
      );
  }
}
