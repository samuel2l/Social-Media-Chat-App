
import 'package:flutter/material.dart';
import 'package:social_media_chat_app/features/auth/screens/login.dart';
import 'package:social_media_chat_app/features/auth/screens/otp.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );

      case OTP.routeName:
      final String verificationId=settings.arguments as String;
      return MaterialPageRoute(
         
        builder: (context) =>OTP(verificationId: verificationId,),
      );
      
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: Center(child: Text('This page does not exist'),),
        ),
      );
  }
}