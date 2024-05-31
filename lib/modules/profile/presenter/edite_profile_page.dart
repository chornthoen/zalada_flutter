import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:zalada_flutter/shared/colors/app_color.dart';
import 'package:zalada_flutter/shared/spacing/app_spacing.dart';
import 'package:zalada_flutter/shared/widgets/custom_app_bar.dart';
import 'package:zalada_flutter/shared/widgets/filled_button_custom.dart';
import 'package:zalada_flutter/shared/widgets/text_field_custom.dart';

class EditeProfilePage extends StatefulWidget {
  const EditeProfilePage({super.key});

  static const routePath = '/edite-profile';

  @override
  State<EditeProfilePage> createState() => _EditeProfilePageState();
}

class _EditeProfilePageState extends State<EditeProfilePage> {
  late TextEditingController fullNameController;
  late TextEditingController emailController;
  late TextEditingController phoneNumberController;
  late TextEditingController genderController;
  late TextEditingController dateOfBirthController;

  @override
  void initState() {
    fullNameController = TextEditingController(text: 'Chorn THOEN');
    emailController = TextEditingController(text: 'thoenchorn@gmail.com');
    phoneNumberController = TextEditingController(text: '081234567890');
    dateOfBirthController = TextEditingController(text: '1997-02-11');
    genderController = TextEditingController(text: 'Female');

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    fullNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    dateOfBirthController.dispose();
    genderController.dispose();
  }

  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: CustomAppBar(title: 'Edite Profile'),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
            ),
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          ClipOval(
                            child: Image.network(
                              'https://static.vecteezy.com/system/resources/thumbnails/008/846/297/small_2x/cute-boy-avatar-png.png',
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(AppSpacing.xs),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(AppSpacing.xs),
                                color: AppColors.kPrimaryColor.withOpacity(0.8),
                              ),
                              child: Icon(
                                PhosphorIconsRegular.pencilSimpleLine,
                                color: AppColors.kWhiteColor,
                                size: AppSpacing.xlg,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xlg),
                    TextFieldCustom(
                      controller: fullNameController,
                      label: 'Full Name',
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(height: AppSpacing.xlg),
                    TextFieldCustom(
                      label: 'Email Address',
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: AppSpacing.xlg),
                    TextFieldCustom(
                      label: 'Date of Birth',
                      controller: dateOfBirthController,
                      suffix: PhosphorIconsRegular.calendar,
                      onSuffixTap: selectDate,
                    ),
                    const SizedBox(height: AppSpacing.xlg),
                    TextFieldCustom(
                      label: 'Phone Number',
                      controller: phoneNumberController,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: AppSpacing.xlg),
                    GestureDetector(
                      onTap: () {
                        DropdownMenuItem<String>(
                          value: selectedGender,
                          child: Text(selectedGender!),
                        );
                      },
                      child: TextFieldCustom(
                        label: 'Gender',
                        enabled: false,
                        controller: genderController,
                        suffix: PhosphorIconsRegular.caretDown,
                        onSuffixTap: () {
                          DropdownMenuItem<String>(
                            value: selectedGender,
                            child: Text(selectedGender!),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.xlg,
          ),
          child: FilledButtonCustom(
            onPressed: () {
              Navigator.of(context).pop();
            },
            text: 'Save Changes',
          ),
        ),
      ),
    );
  }

  Future<void> selectDate() {
    return showCupertinoModalPopup<void>(
      context: context,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height / 2.5,
        decoration: BoxDecoration(
          color: AppColors.kWhiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppSpacing.sm),
            topRight: Radius.circular(AppSpacing.sm),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CupertinoButton(
              child: Text(
                'Done',
                style: TextStyle(
                  fontSize: AppSpacing.lg,
                  color: AppColors.kPrimaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: DateTime.now(),
                minimumDate: DateTime(1990),
                maximumDate: DateTime.now(),
                onDateTimeChanged: (DateTime newDateTime) {
                  setState(() {
                    dateOfBirthController.text =
                        newDateTime.toString().split(' ')[0];
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
