import 'package:flutter/material.dart';
import 'package:social_media_chat_app/colors.dart';
import 'package:social_media_chat_app/screens/mobile_layout_screen.dart';
import 'package:social_media_chat_app/screens/web_layout_screen.dart';
import 'package:social_media_chat_app/utils/responsive_layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Whatsapp UI',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
      ),
      home: const ResponsiveLayout(
        mobileScreenLayout: MobileLayoutScreen(),
        webScreenLayout: WebLayoutScreen(),
      ),
    );
  }
}
