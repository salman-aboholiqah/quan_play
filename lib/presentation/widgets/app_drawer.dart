import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_player/core/theme/app_theme.dart';
import 'package:url_player/presentation/bloc/cubit/theme_cubit.dart';
import 'package:url_player/l10n/generated/app_localizations.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient:
                  isDark ? AppTheme.darkGrayGradient : AppTheme.yellowGradient,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.play_circle_filled, size: 64, color: Colors.white),
                  const SizedBox(height: 12),
                  Text(
                    l10n.appTitle,
                    style: AppTheme.headline2Style.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                // Language Settings (Placeholder for now, just shows title)
                ListTile(
                  leading: const Icon(Icons.language),
                  title: Text(l10n.language),
                  trailing: Text(
                    Localizations.localeOf(context).languageCode == 'ar'
                        ? 'العربية'
                        : 'English',
                    style: TextStyle(color: Colors.grey),
                  ),
                  onTap: () {
                    // TODO: Implement language switching dialog or toggle
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Language switching coming soon!'),
                      ),
                    );
                  },
                ),

                // Theme Settings
                BlocBuilder<ThemeCubit, ThemeState>(
                  builder: (context, state) {
                    final isDarkMode = state is ThemeLoaded && state.isDarkMode;
                    return ListTile(
                      leading: Icon(
                        isDarkMode ? Icons.dark_mode : Icons.light_mode,
                      ),
                      title: Text(l10n.theme),
                      trailing: Switch(
                        value: isDarkMode,
                        onChanged: (value) {
                          context.read<ThemeCubit>().toggleTheme(value);
                        },
                      ),
                    );
                  },
                ),

                const Divider(),

                // Privacy Policy
                ListTile(
                  leading: const Icon(Icons.privacy_tip_outlined),
                  title: Text(l10n.privacyPolicy),
                  onTap: () {
                    Navigator.pop(context);
                    _launchUrl(
                      'https://google.com',
                    ); // Replace with actual Privacy Policy URL
                  },
                ),

                // Contact Us
                ListTile(
                  leading: const Icon(Icons.mail_outline),
                  title: Text(l10n.contactUs),
                  onTap: () {
                    Navigator.pop(context);
                    _launchUrl(
                      'mailto:support@example.com',
                    ); // Replace with actual email
                  },
                ),

                const Divider(),

                // About
                ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: Text(l10n.about),
                  subtitle: Text('${l10n.version} 1.0.0'),
                  onTap: () {},
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '© 2024 QuanPlay',
              style: TextStyle(color: Colors.grey, fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
}
