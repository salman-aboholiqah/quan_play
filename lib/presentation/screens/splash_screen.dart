// Splash screen displayed when the app first launches.
//
// Shows an animated welcome message and navigates to the home screen
// after the animation completes.

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:url_player/l10n/generated/app_localizations.dart';
import 'package:url_player/core/theme/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppTheme.yellowGradient),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Typing animation for app name
              AnimatedTextKit(
                onFinished: () {
                  Navigator.pushReplacementNamed(context, '/home');
                },
                animatedTexts: [
                  TypewriterAnimatedText(
                    AppLocalizations.of(context)!.appTitle,
                    textStyle: AppTheme.headlineStyle,
                    speed: const Duration(milliseconds: 100),
                    textAlign: TextAlign.center,
                  ),
                ],
                totalRepeatCount: 1,
                displayFullTextOnTap: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
