import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media_chat_app/features/auth/respository/auth_repository.dart';

final authControllerProvider = Provider(
    (ref) => AuthController(authRepository: ref.watch(authRepositoryProvider)));

class AuthController {
  final AuthRepository authRepository;

  AuthController({required this.authRepository});

  void signInWPhone(BuildContext context, String number) async {
    authRepository.signInWPhone(context, number);
  }

  void verifyOTP(context, verificationId, userOTP) async {
    authRepository.verifyOTP(
      context,
      verificationId,
      userOTP,
    );
  }
}
