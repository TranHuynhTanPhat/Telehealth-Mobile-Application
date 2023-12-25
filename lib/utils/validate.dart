import 'package:flutter/material.dart';
import 'package:healthline/utils/translate.dart';

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
        ? translate(context, 'please_enter_email')
        : !regex.hasMatch(value)
            ? translate(context, 'invalid_email')
            : null;
  }

  String? validatePassword(BuildContext context, String? value) {
    RegExp uppercase = RegExp(r'^(?=.*[A-Z])');
    RegExp lowercase = RegExp(r'^(?=.*[a-z])');
    RegExp number = RegExp(r'^(?=.*[0-9])');
    RegExp special = RegExp(r'^(?=.*[\$\]\\`~!@#&*~%^&*()+=_{}[|;:<>,.?/-])');
    RegExp regex = RegExp(
        r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[\$\]\\`~!@#&*~%^&*()+=_{}[|;:<>,.?/-]).{8,}$');

    String error = "";

    if (value!.isEmpty) {
      return translate(context, 'please_enter_password');
    } else if (!regex.hasMatch(value)) {
      if (value.length < 8) {
        error += error.isNotEmpty ? "\n" : "";
        error += '- ${translate(context, 'least_8_characters_long')}';
      }
      if (!uppercase.hasMatch(value)) {
        error += error.isNotEmpty ? "\n" : "";
        error += '- ${translate(context, 'least_1_uppercase')}';
      }
      if (!lowercase.hasMatch(value)) {
        error += error.isNotEmpty ? "\n" : "";
        error += '- ${translate(context, 'least_1_lowercase')}';
      }
      if (!number.hasMatch(value)) {
        error += error.isNotEmpty ? "\n" : "";
        error += '- ${translate(context, 'least_1_number')}';
      }
      if (!special.hasMatch(value)) {
        error += error.isNotEmpty ? "\n" : "";
        error += '- ${translate(context, 'least_1_special_character')}';
      }
      return error;
    }
    return null;
  }

  String? validatePhone(BuildContext context, String phone) {
    RegExp uppercase = RegExp(r'^(?=.*[A-Z])');
    RegExp lowercase = RegExp(r'^(?=.*[a-z])');
    RegExp special = RegExp(r'^(?=.*?[!@#\$&*~])');

    if (phone.isEmpty) return translate(context, 'please_enter_phone_number');

    if (phone.characters.first == '0') {
      phone = phone.replaceFirst('0', '');
    }

    if (uppercase.hasMatch(phone) ||
        lowercase.hasMatch(phone) ||
        special.hasMatch(phone) ||
        phone.length != 9) {
      return translate(context, 'invalid_phone');
    }
    return null;
  }

  String changePhoneFormat(String phone) {
    if (phone.length == 10 && phone.characters.first == '0') {
      phone = phone.replaceFirst('0', '');
    }
    return '+84$phone';
  }

  String? validateSpecialCharacter(BuildContext context, String value) {
    // Biểu thức chính quy để kiểm tra ký tự đặc biệt
    RegExp specialCharRegex = RegExp(r'[!@#%^&*(),.?":{}|<>]');

    // Kiểm tra xem chuỗi có chứa ký tự đặc biệt hay không
    if (specialCharRegex.hasMatch(value)) {
      return translate(context, 'special_characters');
    }
    return null;
  }
}
