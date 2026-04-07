import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sandhai_admin/common/utils/toast_utils.dart';
import 'package:sandhai_admin/common/widgets/custom_button/custom_elevated_button.dart';
import 'package:sandhai_admin/common/widgets/custom_scaffold/custom_scaffold.dart';
import 'package:sandhai_admin/common/widgets/custom_text_field/custom_text_form_field.dart';
import 'package:go_router/go_router.dart';
import 'package:sandhai_admin/config/router/app_routes.dart';
import 'package:sandhai_admin/core/auth/auth_repository_scope.dart';

class OtpVerifyPage extends StatefulWidget {
  const OtpVerifyPage({super.key, required this.phone});

  /// E.164-style phone passed from [PhoneLoginPage] via [GoRouterState.extra].
  final String phone;

  @override
  State<OtpVerifyPage> createState() => _OtpVerifyPageState();
}

class _OtpVerifyPageState extends State<OtpVerifyPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _otpController = TextEditingController();
  bool _submitting = false;
  bool _resending = false;

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  String? _validateOtp(String? value) {
    final String v = value?.trim() ?? '';
    if (v.length != 6) {
      return 'Enter the 6-digit OTP';
    }
    return null;
  }

  Future<void> _verify() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    setState(() => _submitting = true);
    final result = await AuthRepositoryScope.of(context).verifyAdminOtp(
      phone: widget.phone,
      otp: _otpController.text.trim(),
    );
    if (!mounted) {
      return;
    }
    setState(() => _submitting = false);

    result.when(
      success: (_) {
        ToastUtils.showSuccessToast('Signed in');
        // Router redirect (auth revision) sends user to the dashboard.
      },
      failure: (e) => ToastUtils.showErrorToast(e.message),
    );
  }

  Future<void> _resend() async {
    setState(() => _resending = true);
    final result =
        await AuthRepositoryScope.of(context).sendAdminOtp(widget.phone);
    if (!mounted) {
      return;
    }
    setState(() => _resending = false);
    result.when(
      success: (_) => ToastUtils.showSuccessToast('OTP sent again'),
      failure: (e) => ToastUtils.showErrorToast(e.message),
    );
  }

  String _maskedPhone(String phone) {
    if (phone.length <= 4) {
      return phone;
    }
    return '${phone.substring(0, phone.length > 6 ? 3 : 1)}…${phone.substring(phone.length - 2)}';
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
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: () => context.go(AppRoutes.login),
                        icon: const Icon(Icons.arrow_back_rounded),
                        tooltip: 'Back',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Icon(
                      Icons.sms_outlined,
                      size: 48,
                      color: scheme.primary,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Enter OTP',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Code sent to ${_maskedPhone(widget.phone)}',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: scheme.onSurfaceVariant,
                          ),
                    ),
                    const SizedBox(height: 32),
                    CustomTextFormField(
                      controller: _otpController,
                      labelText: '6-digit OTP',
                      hintText: '000000',
                      keyboardType: TextInputType.number,
                      autoFocus: true,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(6),
                      ],
                      validator: _validateOtp,
                      onFieldSubmitted: (_) => _verify(),
                    ),
                    const SizedBox(height: 24),
                    CustomElevatedButton(
                      buttonName: _submitting ? 'Verifying…' : 'Verify & continue',
                      buttonAction: _submitting ? null : _verify,
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: (_resending || _submitting) ? null : _resend,
                      child: Text(_resending ? 'Sending…' : 'Resend OTP'),
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
