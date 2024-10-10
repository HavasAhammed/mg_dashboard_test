import 'package:flutter/material.dart';
// import 'package:gotoken_hms/AppTheme/Localization/Languages.dart';

class CustomText extends StatelessWidget {
  const CustomText(
    this.text, {
    Key? key,
    this.fontSize,
    this.textAlign,
    this.textColor,
    this.fontWeight,
    this.maxLine,
    this.overflow,
    this.textDecoration,
  });
  final String? text;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final int? maxLine;
  final TextOverflow? overflow;
  final TextDecoration? textDecoration;

  @override
  Widget build(BuildContext context) {
    return Text(
      (text ?? ""),
      textAlign: textAlign,
      maxLines: maxLine,
      overflow: overflow,
      softWrap: true,
      style: TextStyle(
          fontSize: fontSize ?? 12,
          color: textColor,
          fontWeight: fontWeight,
          decoration: textDecoration),
    );
  }
}
