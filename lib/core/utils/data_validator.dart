import 'package:evently_c16_mon/l10n/generated/app_localizations.dart';

class DataValidator {
  static String? validateUserName(String name, AppLocalizations locale) {
    if (name.isEmpty) {
      return locale.userNameRequired;
    } else if (!RegExp(
      r'^[A-Za-z\u0600-\u06FF]+(?: [A-Za-z\u0600-\u06FF]+)*$',
    ).hasMatch(name)) {
      return locale.userNameInvalid;
    }
    return null;
  }

  static String? validateEmail(String email, AppLocalizations locale) {
    if (email.isEmpty) {
      return locale.emailRequired;
    } else if (!RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(email)) {
      return locale.emailInvalid;
    }
    return null;
  }

  static String? validatePassword(String password, AppLocalizations locale) {
    if (password.isEmpty) {
      return locale.passwordRequired;
    } else if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return locale.passwordUppercase;
    } else if (!RegExp(r'[a-z]').hasMatch(password)) {
      return locale.passwordLowercase;
    } else if (!RegExp(r'[0-9]').hasMatch(password)) {
      return locale.passwordNumber;
    } else if (!RegExp(r'[!@#\$&*~]').hasMatch(password)) {
      return locale.passwordSpecialChar;
    } else if (!RegExp(r'^.{8,}$').hasMatch(password)) {
      return locale.passwordLength;
    }
    return null;
  }

  static String? validateRePassword(String rePassword , String password , AppLocalizations locale){
    if (rePassword.isEmpty) {
      return locale.rePasswordRequired;
    } else if (rePassword != password) {
      return locale.passwordsNotMatch;
    }
    return null;
  }
}
