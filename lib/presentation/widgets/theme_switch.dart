import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_player/presentation/bloc/cubit/theme_cubit.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final isDarkMode = state is ThemeLoaded && state.isDarkMode;

        return GestureDetector(
          child: Icon(
            isDarkMode ? Icons.light_mode : Icons.dark_mode,
            color: !isDarkMode ? Colors.white70 : null,
          ),
          onTap: () {
            context.read<ThemeCubit>().toggleTheme(!isDarkMode);
          },
        );
      },
    );
  }
}
