import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    this.label,
    this.hint,
    this.textInputType = TextInputType.text,
    this.obscureText = false,
    this.enableSuggestions = false,
    this.autocorrect = false,
    required this.controller,
    this.error,
    this.suffixIcon,
    this.filled = false,
    this.fillColor = white,
    this.enabledBorderColor = colorA8B1CE,
    this.focusedBorderColor = color1F1F1F,
    this.suffix,
    this.prefix,
    required this.validate,
    this.readOnly = false,
    this.onTap,
  });
  final TextEditingController controller;
  final String? label;
  final String? hint;
  final String? error;
  final TextInputType? textInputType;
  final bool? obscureText;
  final bool? enableSuggestions;
  final bool? autocorrect;
  final IconButton? suffixIcon;
  final Widget? suffix;
  final bool? filled;
  final Color? fillColor;
  final Color? enabledBorderColor;
  final Color? focusedBorderColor;
  final Widget? prefix;
  final String? Function(String?) validate;
  final bool readOnly;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      readOnly: readOnly,
      validator: validate,
      controller: controller,
      style: Theme.of(context).textTheme.bodyLarge,
      keyboardType: textInputType,
      obscureText: obscureText!,
      enableSuggestions: enableSuggestions!,
      autocorrect: autocorrect!,
      decoration: InputDecoration(
        fillColor: fillColor,
        filled: filled,
        contentPadding: EdgeInsets.all(dimensHeight() * 2),
        labelText: label,
        // labelStyle: Theme.of(context).textTheme.bodyLarge,
        floatingLabelStyle: Theme.of(context)
            .textTheme
            .labelLarge
            ?.copyWith(color: color1F1F1F),
        hintText: hint,
        hintStyle: Theme.of(context)
            .textTheme
            .labelLarge
            ?.copyWith(color: colorA8B1CE),
        errorText: error,
        suffixIcon: suffixIcon,
        suffix: suffix,
        prefix: prefix,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(width: 1, color: enabledBorderColor!),
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(width: 1, color: enabledBorderColor!)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(width: 1, color: focusedBorderColor!)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(width: 1, color: Colors.redAccent)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(width: 1, color: Colors.redAccent)),
      ),
    );
  }
}
