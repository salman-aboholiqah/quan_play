// Main home screen displaying saved video links.
//
// Features:
// - Displays list of saved video links
// - Search functionality
// - Add new links via floating action button
// - Theme switching
// - Animated header with gradient background

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_player/l10n/generated/app_localizations.dart';
import 'package:url_player/core/theme/app_theme.dart';
import 'package:url_player/domain/entities/link_entity.dart';
import 'package:url_player/presentation/bloc/link_bloc/link_bloc.dart';
import 'package:url_player/presentation/screens/search_screen.dart';
import 'package:url_player/presentation/widgets/app_drawer.dart';
import 'package:url_player/presentation/widgets/link_bottom_sheet.dart';
import 'package:url_player/presentation/widgets/link_card.dart';
import 'package:url_player/presentation/widgets/search_bar_widget.dart';
import 'package:url_player/presentation/widgets/theme_switch.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      body: Column(children: [_buildAppBar(), Expanded(child: _buildBody())]),
      floatingActionButton: _buildFAB(context),
    );
  }

  Widget _buildAppBar() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16, 50, 16, _isSearching ? 12 : 24),
      decoration: BoxDecoration(
        gradient:
            Theme.of(context).brightness == Brightness.dark
                ? AppTheme.darkGrayGradient
                : AppTheme.yellowGradient,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Builder(
                builder:
                    (context) => IconButton(
                      icon: const Icon(Icons.menu, color: Colors.white),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
              ),
              Text(
                AppLocalizations.of(context)!.appTitle,
                style: AppTheme.headline2Style.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              // Spacer to balance the row since we have a menu icon on left
              // Check if we want to keep ThemeSwitch here or rely on Drawer
              // Keeping it for now as per plan, but maybe just use SizedBox(width: 48) if we remove it?
              // The user asked for drawer but didn't explicitly say remove existing switch.
              // Let's keep existing switch for now.
              ThemeSwitch(),
            ],
          ),
          const SizedBox(height: 20),

          SearchBarWidget(
            onTap: () async {
              setState(() => _isSearching = true);
              await Future.delayed(const Duration(milliseconds: 400));
              if (mounted) {
                await Navigator.push(
                  // ignore: use_build_context_synchronously
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => const SearchPage(),
                    transitionsBuilder: (
                      context,
                      animation,
                      secondaryAnimation,
                      child,
                    ) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                  ),
                );
                setState(() => _isSearching = false);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: BlocBuilder<LinkBloc, LinkState>(
        builder: (context, state) {
          if (state is LinkLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LinkError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      state.message,
                      style: AppTheme.titleStyle,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<LinkBloc>().add(LoadLinks());
                      },
                      icon: const Icon(Icons.refresh),
                      label: Text(AppLocalizations.of(context)!.retry),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is LinkLoaded) {
            return _buildLinksList(state.links.reversed.toList());
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildLinksList(List<LinkEntity> links) {
    return ListView.builder(
      itemCount: links.length,
      itemBuilder: (context, index) {
        final link = links[index];
        return LinkCard(link: link);
      },
    );
  }

  FloatingActionButton _buildFAB(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _showAddLinkBottomSheet(context),
      shape: CircleBorder(),
      child: const Icon(Icons.add),
    );
  }

  void _showAddLinkBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => LinkBottomSheet(),
    );
  }
}
