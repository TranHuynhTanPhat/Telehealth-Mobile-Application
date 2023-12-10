import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';

class DropdownButtonFieldWidget extends StatelessWidget {
  const DropdownButtonFieldWidget({
    super.key,
    this.label,
    this.hint,
    this.error,
    required this.items,
    required this.onChanged,
    this.value,
    required this.validator,
    this.fillColor = white,
    this.enabledBorderColor = colorA8B1CE,
    this.focusedBorderColor = color1F1F1F,
    this.onTap,
    this.autovalidateMode,
    this.suffixIcon,
    this.prefixIcon,
    this.filled = false,
    this.suffix,
    this.prefix,
  });
  final String? label;
  final String? hint;
  final String? error;
  final List<DropdownMenuItem> items;
  final Function(dynamic) onChanged;
  final dynamic value;
  final String? Function(dynamic) validator;
  final Color? fillColor;
  final Color? enabledBorderColor;
  final Color? focusedBorderColor;
  final Function()? onTap;
  final AutovalidateMode? autovalidateMode;
  final bool? filled;
  final IconButton? suffixIcon;
  final IconButton? prefixIcon;
  final Widget? suffix;
  final Widget? prefix;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        alignLabelWithHint: true,
        fillColor: fillColor,
        filled: filled,
        contentPadding: EdgeInsets.symmetric(horizontal: dimensHeight() * 2),
        labelText: label,
        floatingLabelStyle: Theme.of(context)
            .textTheme
            .labelLarge
            ?.copyWith(color: color1F1F1F),
        hintText: hint,
        hintStyle: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(color: colorA8B1CE, fontWeight: FontWeight.w600),
        errorStyle: Theme.of(context)
            .textTheme
            .bodySmall
            ?.copyWith(color: Colors.redAccent),
        errorText: error,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
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
      onTap: onTap,
      style: Theme.of(context)
          .textTheme
          .bodyLarge
          ?.copyWith(fontWeight: FontWeight.w600),
      autovalidateMode: autovalidateMode,
      items: items,
      onChanged: onChanged,
      value: value,
      validator: validator,
    );
  }
}
