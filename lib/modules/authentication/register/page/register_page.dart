import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:zalada_flutter/gen/assets.gen.dart';
import 'package:zalada_flutter/modules/authentication/widgets/custom_button_social_media.dart';
import 'package:zalada_flutter/modules/authentication/widgets/do_not_account.dart';
import 'package:zalada_flutter/modules/authentication/widgets/or_continue_with.dart';
import 'package:zalada_flutter/shared/colors/app_color.dart';
import 'package:zalada_flutter/shared/spacing/app_spacing.dart';
import 'package:zalada_flutter/shared/widgets/close_keyboard.dart';
import 'package:zalada_flutter/shared/widgets/filled_button_custom.dart';
import 'package:zalada_flutter/shared/widgets/text_field_custom.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  static const String routePath = '/register_page';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  bool obscureText = true;
  bool obscureTextConfirm = true;

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
                    'Create your new\naccount.',
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  SizedBox(height: AppSpacing.xlg + 10),
                  TextFieldCustom(
                    controller: emailController,
                    label: 'Email address',
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: AppSpacing.xlg),
                  TextFieldCustom(
                    controller: passwordController,
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
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: AppSpacing.xlg),
                  TextFieldCustom(
                    controller: confirmPasswordController,
                    onSuffixTap: () {
                      setState(() {
                        obscureTextConfirm = !obscureTextConfirm;
                      });
                    },
                    suffixIcon: SvgPicture.asset(
                      obscureTextConfirm
                          ? Assets.svg.hide.path
                          : Assets.svg.show.path,
                      colorFilter: ColorFilter.mode(
                        AppColors.kPrimaryColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    label: 'Confirm Password',
                    obscureText: obscureTextConfirm,
                  ),
                  SizedBox(height: AppSpacing.xxlg),
                  FilledButtonCustom(
                    onPressed: () {},
                    text: 'Register',
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
                      context.pop();
                    },
                    text: 'Already have an account?',
                    textButton: 'Login',
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
