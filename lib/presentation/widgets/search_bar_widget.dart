// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:url_player/l10n/generated/app_localizations.dart';

class SearchBarWidget extends StatelessWidget {
  final ValueChanged<String>? onSearchChanged;
  final void Function()? onTap;
  final bool enabled;
  const SearchBarWidget({
    super.key,
    this.onSearchChanged,
    this.enabled = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Hero(
      tag: 'search-field',
      child: Material(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: onTap,
          child: TextField(
            enabled: enabled,
            autofocus: enabled,
            onChanged: onSearchChanged,
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              filled: true,
              hintText: AppLocalizations.of(context)!.searchHint,
              prefixIcon: Icon(
                Icons.search,
                color:
                    enabled
                        ? null
                        : !isDark
                        ? Colors.white.withOpacity(0.6)
                        : null,
              ),
              hintStyle: TextStyle(
                color:
                    isDark
                        ? Colors.grey[400]
                        : enabled
                        ? Colors.grey[700]
                        : Colors.white.withOpacity(0.7),
                fontSize: 15,
              ),
              fillColor:
                  isDark
                      ? Colors.grey[800]!.withOpacity(0.4)
                      : enabled
                      ? Colors.grey[300]
                      : Colors.white.withOpacity(0.4),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(12),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color:
                      isDark
                          ? Colors.grey[800]!.withOpacity(0.2)
                          : Colors.white.withOpacity(0.4),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    // return Padding(
    //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    //   child: TextField(
    //     decoration: InputDecoration(
    //       hintText: 'Search links...',
    //       prefixIcon: const Icon(Icons.search),
    //       hintStyle: TextStyle(
    //         color: isDark ? Colors.grey[400] : Colors.grey[700],
    //       ),
    //       fillColor: isDark ? Colors.grey[850] : Colors.grey[200],
    //       filled: true,
    //       contentPadding: const EdgeInsets.symmetric(
    //         horizontal: 20,
    //         vertical: 14,
    //       ),
    //       border: OutlineInputBorder(
    //         borderRadius: BorderRadius.circular(16),
    //         borderSide: BorderSide.none,
    //       ),
    //     ),
    //     onChanged: onSearchChanged,
    //   ),
    // );
  }
}
