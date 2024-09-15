import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media_chat_app/features/auth/controller/auth_controller.dart';

class OTP extends ConsumerWidget {
    static const routeName = '/otp-screen';
    final String verificationId;

  const OTP({super.key, required this.verificationId});

  void verifyOTP(context,userOTP,WidgetRef ref){
    ref.read(authControllerProvider).verifyOTP(context, verificationId, userOTP);

  }

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return  SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              const Text('An SMS has been sent to said number'),
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: TextField(
                decoration:const InputDecoration(
                  hintText: '------'
                ),
                onChanged: (value) {
                  if(value.length==6){
                    verifyOTP(context, value.trim(), ref);
                  }
                },
                ),
              )
      
            ],
          ),
        ),
      ),
    );
  }
}