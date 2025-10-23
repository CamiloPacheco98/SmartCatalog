import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_catalog/extensions/context_extensions.dart';
import 'package:smart_catalog/core/utils/validators.dart';
import 'package:smart_catalog/features/auth/presentation/login.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_catalog/features/auth/presentation/widgets/forgot_password_modal.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text('login.title'.tr(), style: context.textTheme.titleMedium),
              const SizedBox(height: 24),
              Text(
                'login.description'.tr(),
                style: context.textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(hintText: 'login.email'.tr()),
                      validator: Validators.email,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintText: 'login.password'.tr(),
                      ),
                      obscureText: true,
                      validator: Validators.password,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          ForgotPasswordModal.show(
                            context: context,
                            onAccept: (email) {
                              context.read<LoginCubit>().forgotPassword(email);
                              if (context.mounted) {
                                context.pop();
                              }
                            },
                          );
                        },
                        child: Text(
                          'login.forgot_password'.tr(),
                          style: context.textTheme.bodySmall?.copyWith(
                            decoration: TextDecoration.underline,
                            decorationColor: context.colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
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
                            if (_formKey.currentState!.validate()) {
                              context.read<LoginCubit>().login(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              );
                            }
                          },
                          child: Text(
                            'login.submit'.tr(),
                            style: context.textTheme.labelLarge,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
