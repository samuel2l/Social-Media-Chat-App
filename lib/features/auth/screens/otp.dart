import 'package:flutter/material.dart';

class OTP extends StatefulWidget {
    static const routeName = '/otp-screen';
    final String verificationId;

  const OTP({super.key, required this.verificationId});

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('An SMS has been sent to said number'),
            TextField(
            decoration: InputDecoration(
              hintText: '------'
            ),
            )

          ],
        ),
      ),
    );
  }
}