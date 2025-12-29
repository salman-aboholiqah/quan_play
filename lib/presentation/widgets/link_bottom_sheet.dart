// Bottom sheet widget for adding or editing video links.
//
// Provides a form interface for users to add new links or edit existing ones.
// Handles validation, submission, and displays success/error messages.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_player/l10n/generated/app_localizations.dart';
import 'package:url_player/core/services/service_locator.dart';
import 'package:url_player/core/theme/app_theme.dart';
import 'package:url_player/domain/entities/link_entity.dart';
import 'package:url_player/presentation/bloc/link_bloc/link_bloc.dart';

class LinkBottomSheet extends StatefulWidget {
  const LinkBottomSheet({super.key, this.linkEntity});
  final LinkEntity? linkEntity;
  @override
  State<LinkBottomSheet> createState() => _LinkBottomSheetState();
}

class _LinkBottomSheetState extends State<LinkBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _urlController = TextEditingController();

  late LinkBloc _linkBloc;

  @override
  void initState() {
    _linkBloc = sl<LinkBloc>();
    if (widget.linkEntity != null) {
      _titleController.text = widget.linkEntity?.title ?? '';
      _urlController.text = widget.linkEntity?.url ?? '';
    }
    setState(() {});
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _urlController.dispose();
    _linkBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: BlocListener<LinkBloc, LinkState>(
          bloc: _linkBloc,
          listener: (context, state) {
            if (state is LinkError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      const Icon(Icons.error_outline, color: Colors.white),
                      const SizedBox(width: 12),
                      Expanded(child: Text(state.message)),
                    ],
                  ),
                  backgroundColor: AppTheme.redDarkPastel,
                  duration: const Duration(seconds: 4),
                  behavior: SnackBarBehavior.floating,
                ),
              );
              Navigator.pop(context);
            } else if (state is LinkLoaded) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      const Icon(Icons.check_circle, color: Colors.white),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          widget.linkEntity == null
                              ? AppLocalizations.of(context)!.linkAdded
                              : AppLocalizations.of(context)!.linkUpdated,
                        ),
                      ),
                    ],
                  ),
                  backgroundColor: Colors.green,
                  duration: const Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                ),
              );
              Navigator.pop(context);
              context.read<LinkBloc>().add(LoadLinks());
            }
          },
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.linkEntity == null
                          ? AppLocalizations.of(context)!.addLink
                          : AppLocalizations.of(context)!.updateLink,
                      style: AppTheme.titleStyle,
                    ),
                    IconButton(
                      icon: Icon(Icons.close, size: 24),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                // Title Field
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.enterLinkName,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.requiredTitle;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),

                TextFormField(
                  controller: _urlController,
                  keyboardType: TextInputType.url,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.enterLinkUrl,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.requiredUrl;
                    }
                    final pattern =
                        r'^(https?:\/\/)?([\w\-]+\.)+[\w]{2,}(\/\S*)?$';
                    final regex = RegExp(pattern);

                    if (!regex.hasMatch(value.trim())) {
                      return AppLocalizations.of(context)!.validUrl;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24),

                _buildButton(
                  label:
                      widget.linkEntity == null
                          ? AppLocalizations.of(context)!.saveLink
                          : AppLocalizations.of(context)!.updateLink,
                  icon: Icons.save,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (widget.linkEntity != null) {
                        _linkBloc.add(
                          UpdateLink(
                            LinkEntity(
                              createdAt: widget.linkEntity!.createdAt,
                              id: widget.linkEntity!.id,
                              title: _titleController.text,
                              url: _urlController.text,
                            ),
                          ),
                        );
                      } else {
                        _linkBloc.add(
                          AddLink(
                            LinkEntity(
                              createdAt: DateTime.now(),
                              title: _titleController.text,
                              url: _urlController.text,
                            ),
                          ),
                        );
                      }
                    }
                  },
                ),
                SizedBox(height: 15),
                widget.linkEntity != null
                    ? _buildButton(
                      onPressed: () {
                        _linkBloc.add(DeleteLink(widget.linkEntity!.id));
                        Navigator.pop(context);
                        context.read<LinkBloc>().add(LoadLinks());
                      },
                      label: AppLocalizations.of(context)!.deleteLink,
                      icon: Icons.delete,
                      backgroundColor: AppTheme.redDarkPastel,
                    )
                    : SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox _buildButton({
    IconData? icon,
    required String label,
    required void Function()? onPressed,
    Color? backgroundColor,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: icon != null ? Icon(icon, color: Colors.white) : null,
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppTheme.darkYellow,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),

        onPressed: onPressed,
      ),
    );
  }
}
