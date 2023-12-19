import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget(
      {super.key,
      this.label,
      this.hint,
      this.textInputType,
      this.obscureText = false,
      this.enableSuggestions = true,
      this.autocorrect = false,
       this.controller,
      this.error,
      this.suffixIcon,
      this.prefixIcon,
      this.filled = false,
      this.fillColor = white,
      this.enabledBorderColor = colorA8B1CE,
      this.focusedBorderColor = color1F1F1F,
      this.suffix,
      this.prefix,
      required this.validate,
      this.readOnly = false,
      this.onTap,
      this.maxLine = 1,
      this.enable = true,
      this.onChanged,
      this.focusNode,
      this.autovalidateMode});
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? error;
  final TextInputType? textInputType;
  final bool? obscureText;
  final bool? enableSuggestions;
  final bool? autocorrect;
  final IconButton? suffixIcon;
  final IconButton? prefixIcon;
  final Widget? suffix;
  final bool? filled;
  final Color? fillColor;
  final Color? enabledBorderColor;
  final Color? focusedBorderColor;
  final Widget? prefix;
  final String? Function(String?) validate;
  final bool readOnly;
  final Function()? onTap;
  final int maxLine;
  final bool enable;
  final Function(String)? onChanged;
  final FocusNode? focusNode;
  final AutovalidateMode? autovalidateMode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      onChanged: onChanged,
      enabled: enable,
      maxLines: maxLine,
      textAlign: TextAlign.start,
      onTap: onTap,
      readOnly: readOnly,
      validator: validate,
      controller: controller,
      style: Theme.of(context)
          .textTheme
          .bodyLarge
          ?.copyWith(fontWeight: FontWeight.w500),
      keyboardType: textInputType,
      obscureText: obscureText!,
      enableSuggestions: enableSuggestions!,
      autocorrect: autocorrect!,
      autovalidateMode: autovalidateMode,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        fillColor: fillColor,
        filled: filled,
        contentPadding: EdgeInsets.all(dimensHeight() * 2),
        labelText: label,
        // labelStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: validate!=null?Colors.redAccent:color1F1F1F),
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
    );
  }
}
