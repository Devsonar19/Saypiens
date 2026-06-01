import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saypiens/features/home/data/repositories/user_repo.dart';
import 'package:saypiens/features/home/presentation/bloc/home_bloc.dart';
import 'package:saypiens/features/home/presentation/widgets/gathering_section.dart';
import 'package:saypiens/features/home/presentation/widgets/socials_section.dart';
import 'package:saypiens/firebase_options.dart';
import 'package:saypiens/theme/app_color.dart';
import 'features/home/presentation/widgets/about_us.dart';
import 'features/home/presentation/widgets/hero_main_section.dart';
import 'features/home/presentation/widgets/top_nav_bar.dart';
import 'features/splash/presenstation/pages/splash_screen.dart';

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
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => UserRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => HomeBloc(
              userRepository: context.read<UserRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Saypiens',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
          ),
          home: const SplashScreen(),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final GlobalKey _gatheringsKey = GlobalKey();
  final GlobalKey _socialsKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();

  void _scrollTo(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // 1. Static Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/main_bg.jpeg', // Corrected extension from .jpg to .jpeg
              fit: BoxFit.cover,
              color: Colors.black.withValues(alpha: 0.6), // Darkens the image to keep text readable
              colorBlendMode: BlendMode.darken,
            ),
          ),

          // 2. Scrollable Content
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 100), // Pushes content below the sticky navbar
                const HeroSection(),
                GatheringsSection(key: _gatheringsKey),
                SocialsSection(key: _socialsKey,),
                StorySection(key: _aboutKey),
                const SizedBox(height: 100),
              ],
            ),
          ),

          // 3. Sticky Top Nav Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: TopNavBar(
              onGatheringsTap: () => _scrollTo(_gatheringsKey),
              onSocialsTap: () => _scrollTo(_socialsKey),
              onAboutTap: () => _scrollTo(_aboutKey),
            ),
          ),
        ],
      ),
    );
  }
}
