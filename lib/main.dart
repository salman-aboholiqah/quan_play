// Main entry point for the URL Player application.
//
// Initializes services, handles intent data, and sets up the app with
// BLoC providers for state management.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:url_player/l10n/generated/app_localizations.dart';
import 'package:url_player/core/services/service_locator.dart';
import 'package:url_player/core/theme/app_theme.dart';
import 'package:url_player/core/utils/receive_intent.dart';
import 'package:url_player/data/models/stream_model.dart';
import 'package:url_player/presentation/bloc/cubit/theme_cubit.dart';
import 'package:url_player/presentation/bloc/link_bloc/link_bloc.dart';
import 'package:url_player/presentation/screens/home_screen.dart';
import 'package:url_player/presentation/screens/splash_screen.dart';
import 'package:url_player/presentation/screens/video_player_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependency injection
  await initServiceLocator();

  // Receive stream data from platform intent (if available)
  List<StreamQuality> streamList = [];
  try {
    streamList = await receiveIntentQualities();
  } catch (e) {
    debugPrint('Error receiving intent qualities: $e');
    // Continue with empty list if intent fails
  }

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LinkBloc>(create: (_) => sl<LinkBloc>()..add(LoadLinks())),
        BlocProvider<ThemeCubit>(create: (_) => sl<ThemeCubit>()),
      ],
      child: MyApp(streamQualities: streamList),
    ),
  );
}

/// Root widget of the application.
///
/// Manages theme state and determines the initial screen based on
/// whether stream data was received from an intent.
class MyApp extends StatelessWidget {
  final List<StreamQuality> streamQualities;

  const MyApp({super.key, required this.streamQualities});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final themeData =
            state is ThemeLoaded ? state.themeData : AppTheme.lightTheme;

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('ar'), // Arabic first (Default)
            Locale('en'),
          ],
          locale: const Locale(
            'ar',
          ), // Force default to Arabic explicitly if needed
          theme: themeData,
          darkTheme: AppTheme.darkTheme,
          themeMode:
              state is ThemeLoaded && state.isDarkMode
                  ? ThemeMode.dark
                  : ThemeMode.light,
          // Show video player if stream data received, otherwise show splash
          home:
              streamQualities.isNotEmpty
                  ? VideoPlayerScreen(streams: streamQualities)
                  : const SplashScreen(),
          routes: {'/home': (context) => HomeScreen()},
        );
      },
    );
  }
}
