import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_chat_app/features/auth/screens/otp.dart';
import 'package:social_media_chat_app/features/common/utils/utils.dart';

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRepository({required this.auth, required this.firestore});

  void signInWPhone(BuildContext context, String number) async {
    try {
      await auth.verifyPhoneNumber(
          phoneNumber: number,
          verificationCompleted: (PhoneAuthCredential credential) async {
            await auth.signInWithCredential(credential);
          },
          verificationFailed: (error) => throw Exception(error.message),
          codeSent:(String verificationId, int? resendToken)async{
            Navigator.pushNamed(context, OTP.routeName,arguments: verificationId);

          } ,
          codeAutoRetrievalTimeout: (String verificationId) {},

          );
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}
