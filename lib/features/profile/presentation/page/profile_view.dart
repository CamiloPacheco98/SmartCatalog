import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
  bool editable = false;

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
    _setInitialValues();
    editable = !widget.fromSettings;
  }

  void _setInitialValues() {
    nameController.text = widget.user?.name ?? '';
    lastNameController.text = widget.user?.lastName ?? '';
    documentController.text = widget.user?.documentNumber ?? '';
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
                Row(
                  children: [
                    Text(
                      widget.fromSettings
                          ? 'profile.profile'.tr()
                          : 'profile.create_profile'.tr(),
                      style: context.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8),
                    if (widget.fromSettings &&
                        !(widget.user?.verified ?? false))
                      InkWell(
                        onTap: () => setState(() {
                          editable = !editable;
                          if (!editable) {
                            _setInitialValues();
                          }
                        }),
                        child: Container(
                          decoration: BoxDecoration(
                            color: context.colorScheme.primary.withValues(
                              alpha: 0.1,
                            ),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Icon(
                            !editable ? Icons.edit : Icons.close,
                            color: context.colorScheme.primary,
                            size: 18,
                          ),
                        ),
                      ),
                  ],
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
                      child:
                          selectedImagePath != null ||
                              (widget.user?.imagePath.isNotEmpty ?? false)
                          ? ClipOval(
                              child: widget.fromSettings
                                  ? CachedNetworkImage(
                                      imageUrl: widget.user!.imagePath,
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(),
                                    )
                                  : Image.file(
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
                //status section
                if (widget.fromSettings)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (widget.user?.verified ?? false)
                              ? context.colorScheme.tertiary
                              : context.colorScheme.onTertiary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        widget.user?.verified ?? false
                            ? 'profile.verified'.tr()
                            : 'profile.unverified'.tr(),
                        style: context.textTheme.bodySmall?.copyWith(
                          color: (widget.user?.verified ?? false)
                              ? context.colorScheme.tertiary
                              : context.colorScheme.onTertiary,
                        ),
                      ),
                    ],
                  )
                else
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
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'profile.first_name_required'.tr();
                    }
                    return null;
                  },
                  enabled: editable,
                  readOnly: !editable,
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: lastNameController,
                  decoration: InputDecoration(
                    labelText: 'profile.last_name'.tr(),
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'profile.last_name_required'.tr();
                    }
                    return null;
                  },
                  enabled: editable,
                  readOnly: !editable,
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
                  enabled: editable,
                  readOnly: !editable,
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
                                documentNumber: documentController.text.trim(),
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
                  )
                else if (editable)
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        if (_formKey.currentState!.validate()) {
                          final user = await context
                              .read<ProfileCubit>()
                              .updateProfile(
                                name: nameController.text.trim(),
                                lastName: lastNameController.text.trim(),
                                documentNumber: documentController.text.trim(),
                                imagePath: selectedImagePath,
                              );
                          setState(() {
                            editable = !editable;
                            if (user == null) {
                              _setInitialValues();
                            }
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'profile.update'.tr(),
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
