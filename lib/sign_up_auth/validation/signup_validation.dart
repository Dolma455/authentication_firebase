class SignUpValidation {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    } else if (!value.contains('@')) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    } else if (value.length < 8) {
      return 'Password must contain at least 8 characters';
    }
    return null;
  }
}
