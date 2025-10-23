import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_catalog/core/utils/image_picker_util.dart';
import 'package:smart_catalog/core/utils/informative_modal_util.dart';
import 'package:smart_catalog/extensions/context_extensions.dart';
import 'package:smart_catalog/features/profile/presentation/models/user_viewmodel.dart';
import 'package:smart_catalog/features/profile/presentation/profile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';

class ProfileView extends StatefulWidget {
  final String email;
  final bool fromSettings;
  final UserViewModel? user;

  const ProfileView({
    super.key,
    required this.email,
    required this.fromSettings,
    required this.user,
  });

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final documentController = TextEditingController();

  String? selectedImagePath;

  @override
  void dispose() {
    nameController.dispose();
    lastNameController.dispose();
    documentController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    nameController.text = widget.user?.name ?? '';
    lastNameController.text = widget.user?.lastName ?? '';
    documentController.text = widget.user?.document ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: widget.fromSettings
            ? IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back),
              )
            : null,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  widget.fromSettings
                      ? 'profile.profile'.tr()
                      : 'profile.create_profile'.tr(),
                  style: context.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                if (!widget.fromSettings)
                  Text(
                    'profile.create_profile_subtitle'.tr(),
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.onSurface.withValues(
                        alpha: 0.7,
                      ),
                    ),
                  ),
                const SizedBox(height: 32),

                // Profile Image Section
                Center(
                  child: GestureDetector(
                    onTap: widget.fromSettings ? null : _selectImage,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: context.colorScheme.outline,
                          width: 2,
                        ),
                        color: context.colorScheme.surfaceContainerHighest,
                      ),
                      child: selectedImagePath != null
                          ? ClipOval(
                              child: Image.file(
                                File(selectedImagePath!),
                                fit: BoxFit.cover,
                                width: 120,
                                height: 120,
                              ),
                            )
                          : Icon(
                              Icons.person_add,
                              size: 48,
                              color: context.colorScheme.onSurfaceVariant,
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                if (!widget.fromSettings)
                  Center(
                    child: Text(
                      'profile.profile_image_subtitle'.tr(),
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurface.withValues(
                          alpha: 0.6,
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 32),

                // Form Fields
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'profile.first_name'.tr(),
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'profile.first_name_required'.tr();
                    }
                    return null;
                  },
                  enabled: !widget.fromSettings,
                  readOnly: widget.fromSettings,
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: lastNameController,
                  decoration: InputDecoration(
                    labelText: 'profile.last_name'.tr(),
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'profile.last_name_required'.tr();
                    }
                    return null;
                  },
                  enabled: !widget.fromSettings,
                  readOnly: widget.fromSettings,
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: documentController,
                  decoration: InputDecoration(
                    labelText: 'profile.document'.tr(),
                    prefixIcon: Icon(Icons.badge),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'profile.document_required'.tr();
                    }
                    return null;
                  },
                  enabled: !widget.fromSettings,
                  readOnly: widget.fromSettings,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),

                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'profile.email'.tr(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  readOnly: true,
                  enabled: false,
                  initialValue: widget.user?.email ?? widget.email,
                ),
                const SizedBox(height: 40),

                // Create Button
                if (!widget.fromSettings)
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        if (_formKey.currentState!.validate()) {
                          InformativeModalUtil.showInformativeModal(
                            context: context,
                            title: 'profile.create_profile_confirmation'.tr(),
                            subtitle:
                                'profile.create_profile_confirmation_subtitle'
                                    .tr(),
                            acceptText:
                                'profile.create_profile_confirmation_accept'
                                    .tr(),
                            rejectText:
                                'profile.create_profile_confirmation_reject'
                                    .tr(),
                            onAccept: () {
                              context.read<ProfileCubit>().createProfile(
                                name: nameController.text.trim(),
                                lastName: lastNameController.text.trim(),
                                document: documentController.text.trim(),
                                imagePath: selectedImagePath,
                              );
                            },
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'profile.create'.tr(),
                        style: context.textTheme.labelLarge,
                      ),
                    ),
                  ),
                const SizedBox(height: 20), // Extra padding at bottom
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectImage() async {
    final imagePath = await ImagePickerUtil().showImageSourceDialog(context);
    if (imagePath != null && imagePath.isNotEmpty) {
      setState(() {
        selectedImagePath = imagePath;
      });
    }
  }
}
