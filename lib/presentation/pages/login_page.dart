import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lik_app_2/core/providers/auth_repository_provider.dart';
import 'package:lik_app_2/core/theme/app_colors.dart';
import 'package:lik_app_2/core/theme/app_styles.dart';
import 'package:lik_app_2/core/utils/secure_storage.dart';
import 'package:lik_app_2/domain/models/user.dart';
import 'package:lik_app_2/domain/usecases/login_usecase.dart';
import 'package:lik_app_2/presentation/widgets/custom_button.dart';
import 'package:lik_app_2/presentation/widgets/custom_input_field.dart';

// Providers
final loginUsecaseProvider = Provider<LoginUsecase>((ref) {
  return LoginUsecase(ref.read(authRepositoryProvider));
});

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _passwordVisible = false;
  bool _isLoading = false;
  String _errorMessage = '';

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final user = await ref
          .read(loginUsecaseProvider)
          .execute(
            _usernameController.text.trim(),
            _passwordController.text.trim(),
          );

      await _saveUserData(user);
      _navigateToMainMenu();
    } catch (e) {
      await HapticFeedback.vibrate();
      setState(() => _errorMessage = e.toString());
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _saveUserData(User user) async {
    final storage = SecureStorage();
    await Future.wait([
      storage.saveString("authToken", user.token),
      storage.saveString("userId", user.id.toString()),
      storage.saveString("userGroup", user.groupID),
    ]);
  }

  void _navigateToMainMenu() {
    Navigator.pushReplacementNamed(context, '/main_menu');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // Header Section
              _buildHeader(),
              const SizedBox(height: 32),

              // Form Section
              _buildLoginForm(),

              // Footer Section
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Image.asset('assets/images/liklogo-2.png', width: 120, height: 120),
        const SizedBox(height: 16),
        Text(
          'Selamat Datang',
          style: AppStyles.headlineMedium.copyWith(color: AppColors.primary),
        ),
        const SizedBox(height: 8),
        Text(
          'Silakan masuk untuk melanjutkan',
          style: AppStyles.bodyMedium.copyWith(color: AppColors.grayDark),
        ),
      ],
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomInputField(
            label: 'Username',
            controller: _usernameController,
            icon: Icons.person_outline,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Username tidak boleh kosong';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          CustomInputField(
            label: 'Password',
            controller: _passwordController,
            icon: Icons.lock_outline,
            obscureText: !_passwordVisible,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Password tidak boleh kosong';
              }
              if (value.length < 6) {
                return 'Password minimal 6 karakter';
              }
              return null;
            },
            suffixIcon: IconButton(
              icon: Icon(
                _passwordVisible ? Icons.visibility : Icons.visibility_off,
                color: AppColors.grayDark,
              ),
              onPressed: () {
                setState(() => _passwordVisible = !_passwordVisible);
              },
            ),
          ),
          if (_errorMessage.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                _errorMessage,
                style: AppStyles.errorText,
                textAlign: TextAlign.center,
              ),
            ),
          const SizedBox(height: 24),
          CustomButton(
            onPressed: _isLoading ? null : _login,
            child:
                _isLoading
                    ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                    : const Text('MASUK', style: AppStyles.buttonText),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Column(
        children: [
          Text(
            'PT. Lotus Inti Karya',
            style: AppStyles.bodyMedium.copyWith(color: AppColors.grayDark),
          ),
          Text(
            'Versi 1.1.3',
            style: AppStyles.bodyMedium.copyWith(color: AppColors.grayDark),
          ),
        ],
      ),
    );
  }
}
