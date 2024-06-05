import 'package:flutter/material.dart';
import 'package:zalada_flutter/shared/colors/app_color.dart';
import 'package:zalada_flutter/shared/widgets/custom_animate_border.dart';

class TextFieldCustom extends StatefulWidget {
  const TextFieldCustom({
    required this.label,
    this.suffix,
    this.isPhone,
    this.onSuffixTap,
    this.onPrefixTap,
    this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction = TextInputAction.done,
    this.onSubmitted,
    this.enabled = true,
    this.suffixIcon,
    this.maxLines = 1,
    this.minLines = 1,
    super.key,
  });

  final String label;
  final IconData? suffix;
  final bool? isPhone;
  final VoidCallback? onSuffixTap;
  final VoidCallback? onPrefixTap;
  final TextEditingController? controller;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Function(String)? onSubmitted;
  final bool? enabled;
  final Widget? suffixIcon;
  final int? maxLines;
  final int? minLines;

  @override
  State<TextFieldCustom> createState() => _TextFieldCustomState();
}

class _TextFieldCustomState extends State<TextFieldCustom>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  late Animation<double> alpha;
  final focusNode = FocusNode();

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    final Animation<double> curve =
        CurvedAnimation(parent: controller!, curve: Curves.easeInOut);
    alpha = Tween(begin: 0.0, end: 1.0).animate(curve);

    // controller?.forward();
    controller?.addListener(() {
      setState(() {});
    });
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        controller?.forward();
      } else {
        controller?.reverse();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.kColorGray500,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Theme(
        data: ThemeData(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: AppColors.kPrimaryColor,
              ),
        ),
        child: CustomPaint(
          painter: CustomAnimateBorder(alpha.value),
          child: TextField(
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            onSubmitted: widget.onSubmitted,
            focusNode: focusNode,
            enabled: widget.enabled,
            textInputAction: widget.textInputAction,
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            obscureText: widget.obscureText!,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
            decoration: InputDecoration(
              label: Text(
                widget.label,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: focusNode.hasFocus
                          ? AppColors.kPrimaryColor
                          : AppColors.kColorGray600,
                    ),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              suffixIconConstraints: const BoxConstraints(
                minWidth: 24,
                minHeight: 24,
              ),
              suffixIconColor: focusNode.hasFocus
                  ? AppColors.kPrimaryColor
                  : AppColors.kRedColor,
              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: InkWell(
                    splashColor: Colors.transparent,
                    onTap: widget.onSuffixTap,
                    child: widget.suffixIcon == null
                        ? Icon(
                            widget.suffix,
                            color: focusNode.hasFocus
                                ? AppColors.kPrimaryColor
                                : AppColors.kColorGray600,
                          )
                        : widget.suffixIcon!),
              ),
              // suffixIcon: IconButton(
              //   onPressed: widget.onSuffixTap,
              //   icon: Icon(widget.suffix),
              //   color: focusNode.hasFocus
              //       ? AppColors.kPrimaryColor
              //       : AppColors.kColorGray600,
              // ),
              prefixIcon: widget.isPhone == null
                  ? null
                  : InkWell(
                      onTap: widget.onPrefixTap,
                      borderRadius: BorderRadius.circular(24),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 4),
                          Text(
                            '🇰🇭',
                            style: TextStyle(fontSize: 26),
                          ),
                          Icon(Icons.arrow_drop_down, size: 24),
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
