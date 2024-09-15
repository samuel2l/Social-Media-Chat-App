import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media_chat_app/features/auth/screens/otp.dart';
import 'package:social_media_chat_app/features/auth/screens/user_profile.dart';
import 'package:social_media_chat_app/features/common/utils/utils.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(
    auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance));

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
        verificationFailed: (error) {
          showSnackBar(content: error.toString(), context: context);
        },
        codeSent: (String verificationId, int? resendToken) async {
          Navigator.pushNamed(context, OTP.routeName,
              arguments: verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  void verifyOTP(
      BuildContext context, String? verificationId, String userOTP) async {
    try {
      if (verificationId != null && verificationId.isNotEmpty) {
        // Create the phone auth credential with the verification ID and the OTP
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: userOTP,
        );

        // Sign in with the credential
        await auth.signInWithCredential(credential);

        // Navigate to the user profile screen after successful sign-in
        Navigator.pushNamedAndRemoveUntil(
          context,
          UserProfileScreen.routeName,
          (route) => false,
        );
      } else {
        // Handle null or empty verification ID
        showSnackBar(context: context, content: "Verification ID is missing.");
      }
    } catch (e) {
      // Handle the error and show it in a snackbar
      showSnackBar(context: context, content: e.toString());
    }
  }
}
