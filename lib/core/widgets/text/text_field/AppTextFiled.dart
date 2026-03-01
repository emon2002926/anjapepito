import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/app_colors.dart';
import '../../../util/screen_size.dart';
import '../app_text.dart';


class AppTextField extends StatelessWidget {
  final String? label;
  final String? label2;
  final String? hintText;
  final TextEditingController? controller;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;
  final VoidCallback? suffixIconOnTap;
  final VoidCallback? onSuffixIconTap;
  final Color? borderColor;
  final TextInputType? keyboardType;
  final bool enabled;
  final VoidCallback? label2OnClick;
  final Color? fillColor;
  final Color? inputTextColor;
  final Color? hintTextColor;
  final double elevation;
  final Color? shadowColor;
  final BorderRadius? customBorderRadius;
  final bool isHintTextInMiddle;

  const AppTextField({
    super.key,
    this.label,
    this.label2,
    this.label2OnClick,
    this.hintText,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.validator,
    this.focusNode,
    this.suffixIconOnTap,
    this.onSuffixIconTap,
    this.borderColor,
    this.keyboardType,
    this.enabled = true,
    this.fillColor,
    this.inputTextColor,
    this.hintTextColor,
    this.elevation = 8,
    this.shadowColor,
    this.customBorderRadius,
    this.isHintTextInMiddle = false,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveSuffixTap = suffixIconOnTap ?? onSuffixIconTap;

    final double inputFontSize     = context.responsiveFontSize(14);
    final double iconSize          = context.responsiveSize(20);
    final double borderRadius      = context.responsiveSize(10);
    final double verticalPadding   = context.responsiveSize(14);
    final double horizontalPadding = context.responsiveSize(16);
    final double spacing           = context.responsiveSize(8);

    final BorderRadius effectiveBorderRadius =
        customBorderRadius ?? BorderRadius.circular(borderRadius);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                data: label!,
                fontWeight: FontWeight.w600,
                color: AppColors.instance.titleTextColor,
                fontSize: 14,
              ),
              if (label2 != null)
                GestureDetector(
                  onTap: label2OnClick,
                  child: Text(
                    label2!,
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w600,
                      color: Colors.blue,
                      fontSize: inputFontSize,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: spacing),
        ],

        Material(
          elevation: elevation,
          shadowColor: shadowColor ?? Colors.black,
          borderRadius: effectiveBorderRadius,
          color: Colors.transparent,
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            validator: validator,
            focusNode: focusNode,
            keyboardType: keyboardType,
            enabled: enabled,
            textAlign: isHintTextInMiddle ? TextAlign.center : TextAlign.start,
            style: GoogleFonts.plusJakartaSans(
              color: inputTextColor,
              fontSize: inputFontSize,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: GoogleFonts.plusJakartaSans(
                color: hintTextColor ?? Colors.grey,
                fontSize: inputFontSize,
                fontWeight: FontWeight.w400,
              ),
              filled: true,
              fillColor: enabled ? fillColor : Colors.grey.shade300,
              prefixIcon: prefixIcon != null
                  ? Icon(prefixIcon, color: Colors.grey[700], size: iconSize)
                  : null,
              suffixIcon: suffixIcon != null
                  ? GestureDetector(
                onTap: effectiveSuffixTap,
                child: Icon(suffixIcon, color: Colors.grey[700], size: iconSize),
              )
                  : null,
              contentPadding: EdgeInsets.symmetric(
                vertical: verticalPadding,
                horizontal: horizontalPadding,
              ),
              border: OutlineInputBorder(
                borderRadius: effectiveBorderRadius,
                borderSide: borderColor != null
                    ? BorderSide(color: borderColor!)
                    : BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: effectiveBorderRadius,
                borderSide: borderColor != null
                    ? BorderSide(color: borderColor!)
                    : BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: effectiveBorderRadius,
                borderSide: borderColor != null
                    ? BorderSide(color: borderColor!)
                    : BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    );
  }


}