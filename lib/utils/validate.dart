import 'package:flutter/material.dart';
import 'package:healthline/res/language/app_localizations.dart';

class Validate {
  String? validateEmail(BuildContext context, String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isEmpty
        ? AppLocalizations.of(context).translate("please_enter_email")
        : !regex.hasMatch(value)
            ? AppLocalizations.of(context)
                .translate("enter_a_valid_email_address")
            : null;
  }

  String? validatePassword(BuildContext context, String? value) {
    RegExp uppercase = RegExp(r'^(?=.*[A-Z])');
    RegExp lowercase = RegExp(r'^(?=.*[a-z])');
    RegExp number = RegExp(r'^(?=.*?[0-9]) ');
    RegExp special = RegExp(r'^(?=.*?[!@#\$&*~])');
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

    String error = "";

    if (value!.isEmpty) {
      return AppLocalizations.of(context).translate("please_enter_password");
    } else if (!regex.hasMatch(value)) {
      if (value.length < 8) {
        error += error.isNotEmpty ? "\n" : "";
        error +=
            '- ${AppLocalizations.of(context).translate("least_8_characters_long")}';
      }
      if (!uppercase.hasMatch(value)) {
        error += error.isNotEmpty ? "\n" : "";
        error +=
            '- ${AppLocalizations.of(context).translate("least_1_uppercase")}';
      }
      if (!lowercase.hasMatch(value)) {
        error += error.isNotEmpty ? "\n" : "";
        error +=
            '- ${AppLocalizations.of(context).translate("least_1_lowercase")}';
      }
      if (!number.hasMatch(value)) {
        error += error.isNotEmpty ? "\n" : "";
        error +=
            '- ${AppLocalizations.of(context).translate("least_1_number")}';
      }
      if (!special.hasMatch(value)) {
        error += error.isNotEmpty ? "\n" : "";
        error +=
            '- ${AppLocalizations.of(context).translate("least_1_special_character")}';
      }
      return error;
    }
    return null;
  }

  String? validatePhone(BuildContext context, String phone) {
    RegExp uppercase = RegExp(r'^(?=.*[A-Z])');
    RegExp lowercase = RegExp(r'^(?=.*[a-z])');
    RegExp special = RegExp(r'^(?=.*?[!@#\$&*~])');
    if (phone.length == 10 && phone.characters.first == '0') {
      phone = phone.replaceFirst('0', '');
    }
    if (uppercase.hasMatch(phone) ||
        lowercase.hasMatch(phone) ||
        special.hasMatch(phone) ||
        phone.length != 9) {
      return AppLocalizations.of(context).translate("invalid_phone");
    }
    return null;
  }

  String changePhoneFormat(String phone) {
    if (phone.length == 10 && phone.characters.first == '0') {
      phone = phone.replaceFirst('0', '');
    }
    return '+84$phone';
  }
}
