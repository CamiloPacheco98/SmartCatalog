import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_catalog/extensions/context_extensions.dart';
import 'package:smart_catalog/features/profile/presentation/profile.dart';
import 'package:easy_localization/easy_localization.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

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
  Widget build(BuildContext context) {
    return Scaffold(
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
                  'profile.create_profile'.tr(),
                  style: context.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'profile.create_profile_subtitle'.tr(),
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(height: 32),

                // Profile Image Section
                Center(
                  child: GestureDetector(
                    onTap: _selectImage,
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
                              child: Image.asset(
                                selectedImagePath!,
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
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 40),

                // Create Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      if (_formKey.currentState!.validate()) {
                        context.read<ProfileCubit>().createProfile(
                          name: nameController.text.trim(),
                          lastName: lastNameController.text.trim(),
                          document: documentController.text.trim(),
                          imagePath: selectedImagePath,
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

  void _selectImage() {
    // For now, we'll just simulate selecting an image
    // In a real app, you would use image_picker or similar
    setState(() {
      selectedImagePath = 'assets/images/logo.png'; // Placeholder
    });
  }
}
