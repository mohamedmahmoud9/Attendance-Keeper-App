import 'package:easy_localization/easy_localization.dart';

class Validator {
  static String? defaultValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return tr('error_filed_required');
    }

    return null;
  }

  static String? name(String? value) {
    if (value != null) {
      value = value.trim();
      if (value.isEmpty) {
        return tr('error_filed_required');
      }
      if (value.split(' ').length < 3) {
        return tr('name_must_trio');
      }
      if (value.length < 3) {
        return tr('name_short_input');
      }
    }
    return null;
  }

  static String? fastOrder(String? value) {
    if (value != null) {
      value = value.trim();
      if (value.isEmpty) {
        return tr('error_filed_required');
      }
      if (value.length < 3) {
        return tr('name_short_input');
      }
    }
    return null;
  }

  static String? registerAddress(String? value) {
    if (value != null) {
      value = value.trim();
      if (value.isEmpty) {
        return tr('error_filed_required');
      }
      if (value.length < 4) {
        return tr('short_address');
      }
    }
    return null;
  }

  static String? text(String? value) {
    if (value != null) {
      value = value.trim();
      if (value.isEmpty) {
        return tr('error_filed_required');
      } else if (!RegExp('[a-zA-Z]').hasMatch(value)) {
        return tr('enter_correct_name');
      }
    }
    return null;
  }

  static String? defaultEmptyValidator(String? value) {
    return null;
  }

  static String? email(String? value) {
    if (value != null) {
      value = value.trim();
      if (value.isEmpty) {
        return tr('error_filed_required');
      } else if (!RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(value)) {
        return tr('error_email_regex');
      }
    } else {
      return tr('error_filed_required');
    }
    return null;
  }

  static String? password(String? value) {
    if (value != null) {
      value = value.trim();
      if (value.isEmpty) {
        return tr('error_filed_required');
      }
      if (value.length < 8) {
        return tr('error_password_validation');
      }
    }
    return null;
  }

  static String? confirmPassword(String? confirmPassword, String? password) {
    if (confirmPassword != null) {
      confirmPassword = confirmPassword.trim();
      if (confirmPassword.isEmpty) {
        return tr('error_filed_required');
      } else if (confirmPassword != password) {
        return tr('error_wrong_password_confirm');
      }
    } else {
      return tr('error_filed_required');
    }
    return null;
  }

  static String? numbers(String? value) {
    if (value != null) {
      value = value.trim();
      if (value.isEmpty) {
        return tr('error_filed_required');
      }
      if (value.startsWith('+')) {
        value = value.replaceFirst(r'+', '');
      }
      final int? number = int.tryParse(value);
      if (number == null) {
        return tr('error_wrong_input');
      }
    } else {
      return tr('error_filed_required');
    }
    return null;
  }

  static String? phone(
    String? value,
  ) {
    RegExp regExp = RegExp(r'^01[0-2-5]{1}[0-9]{8}$');
    if (value == null || value.isEmpty) {
      return tr('error_filed_required');
    }
    if (!regExp.hasMatch(value)) {
      return tr('invalid_phone');
    }
    return null;
  }
}