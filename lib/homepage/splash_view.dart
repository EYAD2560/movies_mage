import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'onboarding_screen.dart'; // Import your onboarding screen

// SplashScreen is the first screen users see when they open the app.
// It shows an animation and automatically navigates to the OnboardingScreen.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      // Widget displayed during the splash
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // App logo
          Image.asset(
            'assets/new logo 2.png',
            height: 120,
          ),
          const SizedBox(height: 20),
        ],
      ),

      // Background color of the splash screen
      backgroundColor: Colors.white,

      // The screen to navigate to after the splash ends
      nextScreen: const OnboardingScreen(),

      // Controls the size of the splash widget
      splashIconSize: 300,

      // Duration the splash stays on screen (in milliseconds)
      duration: 2500,

      // Duration of the transition animation
      animationDuration: const Duration(milliseconds: 1000),

      // Type of animation used to show splash content
      splashTransition: SplashTransition.fadeTransition,

      // Type of transition to switch to the next screen
      pageTransitionType: PageTransitionType.fade,
    );
  }
}
