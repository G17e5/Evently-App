class ValidatorManager {
  /// Validate Name
  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter your name";
    }
    final regEx = RegExp(r'^[a-zA-Z]{2,}$');
    if (!regEx.hasMatch(value.trim())) {
      return "Invalid name format";
    }
    return null;
  }

  /// Validate Email
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter your email";
    }
    final regEx = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regEx.hasMatch(value.trim())) {
      return "Invalid email format";
    }
    return null;
  }

  /// Validate Password (at least 8 chars, include letters and numbers)
  static String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter your password";
    }
    final regEx = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
    if (!regEx.hasMatch(value.trim())) {
      return "Password must be at least 8 characters, include letters and numbers";
    }
    return null;
  }


  /// Validate RePassword (match with original password)
  static String? validateRePassword(String? value, String password) {
    if (value == null || value.trim().isEmpty) {
      return "Please re-enter your password";
    }
    if (value.trim() != password.trim()) {
      return "Passwords do not match";
    }
    return null;
  }
}
