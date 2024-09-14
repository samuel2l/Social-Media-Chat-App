import 'package:flutter/material.dart';
import 'package:social_media_chat_app/utils/colors.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login-screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter phone number'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Center(
            child: TextButton(
              onPressed: () {},
              
              style: TextButton.styleFrom(backgroundColor: tabColor),
            child: const Text('Pick country'),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(18.0),
            child: TextField(
              keyboardType: TextInputType.number,
            ),
          ),
        ],
      ),
    );
  }
}
