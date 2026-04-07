import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:sandhai_admin/common/utils/toast_utils.dart';
import 'package:sandhai_admin/common/widgets/custom_button/custom_elevated_button.dart';
import 'package:sandhai_admin/common/widgets/custom_scaffold/custom_scaffold.dart';
import 'package:sandhai_admin/common/widgets/custom_text_field/custom_text_form_field.dart';
import 'package:sandhai_admin/config/router/app_routes.dart';
import 'package:sandhai_admin/constants/app_strings.dart';
import 'package:sandhai_admin/core/auth/auth_repository_scope.dart';

class PhoneLoginPage extends StatefulWidget {
  const PhoneLoginPage({super.key});

  @override
  State<PhoneLoginPage> createState() => _PhoneLoginPageState();
}

class _PhoneLoginPageState extends State<PhoneLoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  bool _submitting = false;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  String? _validatePhone(String? value) {
    final String v = value?.trim() ?? '';
    if (v.isEmpty) {
      return 'Enter your phone number';
    }
    final String digits = v.replaceAll(RegExp(r'\D'), '');
    if (digits.length < 10 || digits.length > 15) {
      return 'Enter a valid phone number (10–15 digits)';
    }
    return null;
  }

  String _normalizePhone(String raw) {
    final String trimmed = raw.trim().replaceAll(RegExp(r'\s'), '');
    if (trimmed.startsWith('+')) {
      return trimmed;
    }
    final String digits = trimmed.replaceAll(RegExp(r'\D'), '');
    if (digits.length == 10) {
      return '+91$digits';
    }
    return '+$digits';
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    final String normalized = _normalizePhone(_phoneController.text);

    setState(() => _submitting = true);
    final result = await AuthRepositoryScope.of(context).sendAdminOtp(normalized);
    if (!mounted) {
      return;
    }
    setState(() => _submitting = false);

    result.when(
      success: (_) {
        ToastUtils.showSuccessToast('OTP sent to your WhatsApp');
        context.push(AppRoutes.otp, extra: normalized);
      },
      failure: (e) => ToastUtils.showErrorToast(e.message),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;

    return CustomScaffold(
      backgroundColor: scheme.surface,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 24),
                    Icon(
                      Icons.storefront_rounded,
                      size: 56,
                      color: scheme.primary,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      AppStrings.appName,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: scheme.onSurface,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Admin sign-in',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: scheme.onSurfaceVariant,
                          ),
                    ),
                    const SizedBox(height: 36),
                    CustomTextFormField(
                      controller: _phoneController,
                      labelText: 'Phone number',
                      hintText: '+91 9876543210',
                      keyboardType: TextInputType.phone,
                      autoFocus: true,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[\d+\s]')),
                      ],
                      validator: _validatePhone,
                      onFieldSubmitted: (_) => _submit(),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Use the number registered on your admin account. OTP is sent via WhatsApp.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: scheme.onSurfaceVariant,
                            height: 1.35,
                          ),
                    ),
                    const SizedBox(height: 28),
                    CustomElevatedButton(
                      buttonName: _submitting ? 'Sending…' : 'Send OTP',
                      buttonAction: _submitting ? null : _submit,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
