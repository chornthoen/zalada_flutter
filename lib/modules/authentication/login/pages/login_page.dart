import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:zalada_flutter/modules/authentication/forget_password/page/forget_password_page.dart';
import 'package:zalada_flutter/modules/authentication/register/page/register_page.dart';
import 'package:zalada_flutter/modules/authentication/widgets/custom_button_social_media.dart';
import 'package:zalada_flutter/modules/authentication/widgets/do_not_account.dart';
import 'package:zalada_flutter/modules/authentication/widgets/or_continue_with.dart';
import 'package:zalada_flutter/modules/main/presenter/main_page.dart';
import 'package:zalada_flutter/shared/colors/app_color.dart';
import 'package:zalada_flutter/shared/spacing/app_spacing.dart';
import 'package:zalada_flutter/shared/widgets/close_keyboard.dart';
import 'package:zalada_flutter/shared/widgets/custom_elevated.dart';
import 'package:zalada_flutter/shared/widgets/text_field_custom.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const String routePath = '/login_page';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  late LocalAuthentication localAuth;
  bool _supportsLocalAuth = false;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    localAuth = LocalAuthentication();
    localAuth.isDeviceSupported().then((value) {
      setState(() {
        _supportsLocalAuth = value;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => CloseKeyboard.close(context),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xlg,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: AppSpacing.xlg),
                  Text(
                    'Login to your\naccount.',
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  SizedBox(height: AppSpacing.xlg + 20),
                  const TextFieldCustom(
                    label: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: AppSpacing.xlg),
                  TextFieldCustom(
                    onSuffixTap: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                    suffix: obscureText
                        ? PhosphorIconsRegular.eye
                        : PhosphorIconsRegular.eyeSlash,
                    label: 'Password',
                    obscureText: obscureText,
                    onSubmitted: (value) {
                      context.push(MainPage.routePath);
                    },
                  ),
                  SizedBox(height: AppSpacing.sm),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        context.push(ForgetPasswordPage.routePath);
                      },
                      child: Text(
                        'Forgot Password?',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.kPrimaryColor,
                                ),
                      ),
                    ),
                  ),
                  SizedBox(height: AppSpacing.lg),
                  CustomElevated(
                    onPressed: () {
                      context.push(MainPage.routePath);
                    },
                    text: 'Login',
                  ),
                  SizedBox(height: AppSpacing.xlg),
                  OrContinueWith(),
                  SizedBox(height: AppSpacing.xlg),
                  CustomButtonSocialMedia(
                    onTap: () {},
                    text: 'Continue with Apple',
                    icon: 'assets/svg/apple.svg',
                  ),
                  SizedBox(height: AppSpacing.md),
                  CustomButtonSocialMedia(
                    onTap: () {},
                    text: 'Continue with Google',
                    icon: 'assets/svg/google.svg',
                  ),
                  SizedBox(height: AppSpacing.md),
                  CustomButtonSocialMedia(
                    onTap: () {},
                    text: 'Continue with Facebook',
                    icon: 'assets/svg/facebook.svg',
                  ),
                  SizedBox(height: AppSpacing.md),
                  DoNotAccount(
                    onPressed: () {
                      context.push(RegisterPage.routePath);
                    },
                    text: 'Don\'t have an account?',
                    textButton: 'Register',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _authenticate() async {
    try {
      bool isAuthenticated = await localAuth.authenticate(
        localizedReason: 'Please authenticate to show account balance',
        options: const AuthenticationOptions(
          stickyAuth: true,
          sensitiveTransaction: true,
        ),
      );
      if (isAuthenticated) {
        setState(() {
          obscureText = !obscureText;
        });
        // context.push(MainPage.routePath);
      }
    } catch (e) {
      print(e);
    }
  }
}
