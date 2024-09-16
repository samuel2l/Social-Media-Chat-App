import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media_chat_app/features/auth/controller/auth_controller.dart';
import 'package:social_media_chat_app/features/landing/screens/landing.dart';
import 'package:social_media_chat_app/router.dart';
import 'package:social_media_chat_app/screens/mobile_layout_screen.dart';
import 'package:social_media_chat_app/utils/colors.dart';
import 'package:social_media_chat_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Whatsapp UI',
      theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: backgroundColor,
          appBarTheme: const AppBarTheme(color: appBarColor)),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: ref.watch(getUserProvider).when(
            data: (user) {
              if (user == null) {
                return const LandingScreen();
              } else {
                return const MobileLayoutScreen();
              }
            },
            error: (error, stackTrace) {
              print(stackTrace);
              return SafeArea(
                child: Center(
                  child: Text('${error.toString()} ebe here nor o'),
                ),
              );
            },
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
    );
  }
}
