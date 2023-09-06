// import 'package:flutter/material.dart';

// class AppTextField extends StatefulWidget {
//   final TextEditingController? controller;
//   final bool? readOnly;
//   final TextStyle? textStyle;
//   final TextStyle? hintStyle;
//   final String? hintText;
//   final Color? strokeColor;
//   final bool autoFocus;
//   final bool? obscureText;
//   final TextInputType? inputType;
//   final Widget? prefixIcon;
//   final Widget? suffixIcon;
//   final int? maxLength;
//   const AppTextField({
//     this.textStyle,
//     required this.controller,
//     this.hintText,
//     this.hintStyle,
//     this.strokeColor,
//     this.autoFocus = false,
//     this.inputType,
//     this.prefixIcon,
//     this.maxLength,
//     this.suffixIcon,
//     this.readOnly,
//     this.obscureText,
//   });
//   @override
//   State<StatefulWidget> createState() => _AppTextFieldState();
// }

// class _AppTextFieldState extends State<AppTextField> {
//   @override
//   void initState() {
//     super.initState();
//     widget.controller?.addListener(() {
//       setState(() {});
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       readOnly: widget.readOnly ?? false,
//       controller: widget.controller,
//       style: widget.textStyle ?? text20.textColorBlack,
//       autofocus: widget.autoFocus,
//       maxLength: widget.maxLength,
//       obscureText: widget.obscureText ?? false,
//       keyboardType: widget.inputType ?? TextInputType.text,
//       decoration: InputDecoration(
//         counterText: "",
//         hintText: widget.hintText ?? "",
//         hintStyle: widget.hintStyle ??
//             widget.textStyle?.copyWith(color: getColor().hintText) ??
//             text20.hint,
//         suffixIconConstraints:
//             BoxConstraints(maxWidth: 24.ws, maxHeight: 24.ws, minHeight: 24.ws),
//         suffixIcon: widget.suffixIcon ??
//             (widget.controller?.text != ""
//                 ? MaterialButton(
//                     height: 24.ws,
//                     minWidth: 24.ws,
//                     padding: const EdgeInsets.all(0),
//                     onPressed: () => widget.controller?.clear(),
//                     shape: const CircleBorder(),
//                     child: Icon(
//                       Icons.cancel,
//                       size: 24.ws,
//                       color: getColor().hintText,
//                     ),
//                   )
//                 : null),
//         prefixIcon: widget.prefixIcon,
//         isDense: true,
//         contentPadding: const EdgeInsets.symmetric(
//             vertical: Dimens.verticalTextSpacing, horizontal: 0.0),
//         enabledBorder: _underlineInputBorder(widget.strokeColor, context),
//         focusedBorder: _underlineInputBorder(widget.strokeColor, context),
//         border: _underlineInputBorder(widget.strokeColor, context),
//         disabledBorder: _underlineInputBorder(widget.strokeColor, context),
//       ),
//     );
//   }

//   UnderlineInputBorder _underlineInputBorder(
//       Color? strokeColor, BuildContext context) {
//     return UnderlineInputBorder(
//         borderSide: BorderSide(color: strokeColor ?? getColor().borderNeutral));
//   }
// }

import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';

import '../../utils/keyboard.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    this.label,
    this.hint,
    this.textInputType = TextInputType.text,
    this.obscureText = false,
    this.enableSuggestions = false,
    this.autocorrect = false, required this.controller,
  });
  final TextEditingController controller;
  final String? label;
  final String? hint;
  final TextInputType? textInputType;
  final bool? obscureText;
  final bool? enableSuggestions;
  final bool? autocorrect;

  @override
  Widget build(BuildContext context) {
    return TextField(
      
      controller: controller,
      onTap: () => KeyboardUtil.hideKeyboard(context),
      style: Theme.of(context).textTheme.bodyLarge,
      keyboardType: textInputType,
      obscureText: obscureText!,
      enableSuggestions: enableSuggestions!,
      autocorrect: autocorrect!,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(dimensHeight()*2),
          labelText: label,
          // labelStyle: Theme.of(context).textTheme.bodyLarge,
          floatingLabelStyle: Theme.of(context)
              .textTheme
              .labelLarge
              ?.copyWith(color: color1F1F1F),
          hintText: hint,
          hintStyle: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: colorA8B1CE),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(width: 1, color: colorA8B1CE),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(width: 1, color: colorA8B1CE)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(width: 1, color: color1F1F1F)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(width: 1, color: Colors.redAccent)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(width: 1, color: Colors.redAccent))),
    );
  }
}
