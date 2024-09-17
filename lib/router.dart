import 'package:flutter/material.dart';
import 'package:social_media_chat_app/features/auth/screens/login.dart';
import 'package:social_media_chat_app/features/auth/screens/otp.dart';
import 'package:social_media_chat_app/features/auth/screens/user_profile.dart';
import 'package:social_media_chat_app/features/contacts/screens/contacts.dart';
import 'package:social_media_chat_app/screens/mobile_chat_screen.dart';

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
