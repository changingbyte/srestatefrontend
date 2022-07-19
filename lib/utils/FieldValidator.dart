import 'AppString.dart';

class FieldValidator {
  static String? validateEmail(String? value) {

    if (value!.isEmpty) return AppString.emailRequired;

    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regex = new RegExp(pattern.toString());

    if (!regex.hasMatch(value.trim())) {
      return AppString.enterValidEmail;
    }

    return null;
  }

  /// Password matching expression. Password must be at least 4 characters,
  /// no more than 8 characters, and must include at least one upper case letter,
  /// one lower case letter, and one numeric digit.
  static String? validatePassword1(String? value) {

    if (value!.isEmpty) return AppString.enterPassword;

    Pattern pattern = r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{4,8}$';

    RegExp regex = new RegExp(pattern.toString());

    if (!regex.hasMatch(value.trim())) {
      return AppString.enterValidPassword;
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return "Password is Required";
    } else if (value.length < 8) {
      return "Password must minimum eight characters";

    }
    return null;
  }

  static String validateConfirmPassword(String value1,String value2) {
    if (value1.isEmpty) {
      return "Password is Required";
    } else if (value1.length < 8) {
      return "Password must minimum eight characters";
    }else if (value1.toString()!=value2.toString()) {
      return AppString.confirmPwdNotMatch;
    }
    return "";
  }

  static String? validateValueIsEmpty(String value) {
    if (value.isEmpty) {
      return "Value is Required";
    }
    return null;
  }

  static String? validateAddress(String? value) {
    if (value!.isEmpty) {
      return "Please Enter Address";
    }else if(value.length <= 32){
      return "Enter valid Address";
    }
    return null;
  }

  static String? validateAmount(String? value) {
    if (value!.isEmpty) {
      return "Please Enter Amount";
    }else if(double.parse(value) < 0){
      return "Enter valid value";
    }
    return null;
  }

  static String? validateLocalAmount(String value) {
    if (value.isEmpty) {
      return "Please Enter Amount";
    }else if(double.parse(value) <= 0){
      return "Enter valid value";
    }
    return null;
  }
  static String? validateTotalAmount(String value) {
    if (value.isEmpty) {
      return "Please Total Amount";
    }
    return null;
  }

  static String? validateOtp(String value) {
    if (value.isEmpty) {
      return "OTP must have 6 digits";
    } else if (value.length!=6) {
      return "OTP must have 6 digits";
    }
    return null;
  }
}
