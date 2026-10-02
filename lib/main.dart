import 'package:flutter/material.dart';
import 'package:saypiens/features/home/presentation/pages/home_page.dart';
import 'package:saypiens/theme/app_color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:saypiens/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const SaypiensApp());
}

class SaypiensApp extends StatelessWidget {
  const SaypiensApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Saypiens',
      debugShowCheckedModeBanner: false,
      theme: AppColors.themeData,
      home: const HomePage(),
    );
  }
}
