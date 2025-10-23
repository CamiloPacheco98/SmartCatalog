import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:smart_catalog/app/routes/app_path.dart';
import 'package:smart_catalog/core/utils/validators.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_catalog/extensions/context_extensions.dart';

import '../reset_password.dart';

class ResetPasswordView extends StatelessWidget {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.goNamed(AppPaths.login),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Text(
                    'reset_password.title'.tr(),
                    style: context.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'reset_password.subtitle'.tr(),
                    style: context.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      hintText: 'reset_password.password'.tr(),
                    ),
                    validator: Validators.password,
                    obscureText: true,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: confirmPasswordController,
                    decoration: InputDecoration(
                      hintText: 'reset_password.confirm_password'.tr(),
                    ),
                    validator: (value) => Validators.confirmPassword(
                      value,
                      passwordController.text,
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 40,
                      left: 20,
                      right: 20,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          if (formKey.currentState!.validate()) {
                            context.read<ResetPasswordCubit>().resetPassword(
                              newPassword: passwordController.text.trim(),
                            );
                          }
                        },
                        child: Text('reset_password.reset_password'.tr()),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
