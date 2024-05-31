import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';
import 'package:zalada_flutter/gen/assets.gen.dart';
import 'package:zalada_flutter/modules/authentication/forget_password/page/forget_password_page.dart';
import 'package:zalada_flutter/modules/authentication/register/page/register_page.dart';
import 'package:zalada_flutter/modules/authentication/widgets/custom_button_social_media.dart';
import 'package:zalada_flutter/modules/authentication/widgets/do_not_account.dart';
import 'package:zalada_flutter/modules/authentication/widgets/or_continue_with.dart';
import 'package:zalada_flutter/modules/main/presenter/main_page.dart';
import 'package:zalada_flutter/shared/colors/app_color.dart';
import 'package:zalada_flutter/shared/spacing/app_spacing.dart';
import 'package:zalada_flutter/shared/widgets/close_keyboard.dart';
import 'package:zalada_flutter/shared/widgets/filled_button_custom.dart';
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

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    localAuth = LocalAuthentication();
    localAuth.isDeviceSupported().then((value) {
      setState(() {});
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
                    suffixIcon: SvgPicture.asset(
                      obscureText ? Assets.svg.hide.path : Assets.svg.show.path,
                      colorFilter: ColorFilter.mode(
                        AppColors.kPrimaryColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    label: 'Password',
                    obscureText: obscureText,
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
                  FilledButtonCustom(
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
                    icon: Assets.svg.apple.path,
                  ),
                  SizedBox(height: AppSpacing.md),
                  CustomButtonSocialMedia(
                    onTap: () {},
                    text: 'Continue with Google',
                    icon: Assets.svg.google.path,
                  ),
                  SizedBox(height: AppSpacing.md),
                  CustomButtonSocialMedia(
                    onTap: () {},
                    text: 'Continue with Facebook',
                    icon: Assets.svg.facebook.path,
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

  Future<void> authenticate() async {
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
      }
    } catch (e) {
      print(e);
    }
  }
}
