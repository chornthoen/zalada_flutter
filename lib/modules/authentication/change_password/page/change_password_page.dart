import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zalada_flutter/gen/assets.gen.dart';
import 'package:zalada_flutter/shared/colors/app_color.dart';
import 'package:zalada_flutter/shared/spacing/app_spacing.dart';
import 'package:zalada_flutter/shared/widgets/custom_app_bar.dart';
import 'package:zalada_flutter/shared/widgets/filled_button_custom.dart';
import 'package:zalada_flutter/shared/widgets/text_field_custom.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  static const routePath = '/change-password-page';

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  late final TextEditingController _oldPasswordController;
  late final TextEditingController _newPasswordController;
  late final TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _oldPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool obscureTextOld = true;
  bool obscureTextNew = true;
  bool obscureTextConfirm = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Change Password'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: AppSpacing.lg),
              TextFieldCustom(
                label: 'Old Password',
                obscureText: obscureTextOld,
                controller: _oldPasswordController,
                onSuffixTap: () {
                  setState(() {
                    obscureTextOld = !obscureTextOld;
                  });
                },
                suffixIcon: SvgPicture.asset(
                  obscureTextOld ? Assets.svg.hide.path : Assets.svg.show.path,
                  colorFilter: ColorFilter.mode(
                    AppColors.kPrimaryColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              SizedBox(height: AppSpacing.xlg),
              TextFieldCustom(
                label: 'New Password',
                obscureText: obscureTextNew,
                controller: _newPasswordController,
                onSuffixTap: () {
                  setState(() {
                    obscureTextNew = !obscureTextNew;
                  });
                },
                suffixIcon: SvgPicture.asset(
                  obscureTextNew ? Assets.svg.hide.path : Assets.svg.show.path,
                  colorFilter: ColorFilter.mode(
                    AppColors.kPrimaryColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              SizedBox(height: AppSpacing.xlg),
              TextFieldCustom(
                label: 'Confirm Password',
                obscureText: obscureTextConfirm,
                controller: _confirmPasswordController,
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
              ),
              SizedBox(height: AppSpacing.xxxlg),
              FilledButtonCustom(
                onPressed: () {},
                text: 'Save Changes',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
