import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media_chat_app/features/auth/screens/otp.dart';
import 'package:social_media_chat_app/features/auth/screens/user_profile.dart';
import 'package:social_media_chat_app/features/common/utils/utils.dart';

final authRepositoryProvider=Provider((ref) => AuthRepository(auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance));

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
          verificationFailed: (error) => showSnackBar(content: error.toString(),context:context ),
          codeSent:(String verificationId, int? resendToken)async{
            Navigator.pushNamed(context, OTP.routeName,arguments: verificationId);

          } ,
          codeAutoRetrievalTimeout: (String verificationId) {},

          );
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  void verifyOTP(context,verificationId,userOTP)async{
try{
  PhoneAuthCredential credential=PhoneAuthProvider.credential(verificationId: verificationId, smsCode: userOTP);
await auth.signInWithCredential(credential);
Navigator.pushNamedAndRemoveUntil(context, UserProfileScreen.routeName, (route) => false);
}catch(e){
  showSnackBar(context: context, content: e.toString());
}

  }
}
