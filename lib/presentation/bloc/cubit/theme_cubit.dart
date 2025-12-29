// Cubit for managing application theme state.
//
// Handles loading and toggling between light and dark themes.
// Persists theme preference using ThemeRepository.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_player/core/theme/app_theme.dart';
import 'package:url_player/domain/repositories/theme_repository.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final ThemeRepository themeRepository;

  ThemeCubit(this.themeRepository) : super(ThemeInitial()) {
    _loadInitialTheme();
  }

  /// Loads the initial theme from persistent storage.
  /// Called automatically when the cubit is created.
  Future<void> _loadInitialTheme() async {
    final isDark = await themeRepository.isDarkMode();
    emit(
      ThemeLoaded(
        themeData: isDark ? AppTheme.darkTheme : AppTheme.lightTheme,
        isDarkMode: isDark,
      ),
    );
  }

  /// Toggles the theme between light and dark modes.
  ///
  /// [isDark] indicates whether dark mode should be enabled.
  /// Saves the preference and emits the new theme state.
  Future<void> toggleTheme(bool isDark) async {
    await themeRepository.setDarkMode(isDark);
    emit(
      ThemeLoaded(
        themeData: isDark ? AppTheme.darkTheme : AppTheme.lightTheme,
        isDarkMode: isDark,
      ),
    );
  }
}
