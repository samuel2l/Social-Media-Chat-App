import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media_chat_app/features/auth/respository/auth_repository.dart';
import 'package:social_media_chat_app/models/user_model.dart';

final authControllerProvider = Provider(
    (ref) => AuthController(authRepository: ref.read(authRepositoryProvider),ref:ref));

//we will use a specific provider for methods that cannot use the normal provider
//the get user function for getting user data for example will need a future provider

final getUserProvider=FutureProvider<UserModel?>((ref) {
return ref.watch(authControllerProvider).getUser();
});

class AuthController {
  final AuthRepository authRepository;
  final ProviderRef ref;

  AuthController({required this.authRepository,required this.ref});

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
  void saveUserDataToFirebase(    {required String name,
    required File? dp,
    required BuildContext context,})async{
    authRepository.saveUserDataToFirebase(name: name, dp: dp, ref: ref, context: context);
  }
Future<UserModel?> getUser()async{
  UserModel? user=await authRepository.getUser();
return user;

}

Stream<UserModel> checkUserOnline(String uid){
return authRepository.checkUserOnline(uid);

}
}