class TNValidators {
  static String? validateEmptyText(String? value, {String fieldName = 'This field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required.';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email is required.';
    final emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegExp.hasMatch(value)) return 'Invalid email address.';
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required.';
    if (value.length < 6) return 'Password must be at least 6 characters long.';
    if (!value.contains(RegExp(r'[A-Z]'))) return 'Password must contain at least one uppercase letter.';
    if (!value.contains(RegExp(r'[0-9]'))) return 'Password must contain at least one number.';
    if (!value.contains(RegExp(r'[a-z]'))) return 'Password must contain at least one lowercase letter.';
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character.';
    }
    return null;
  }

  static String? validateConfirmPassword(String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) return 'Confirm password is required.';
    if (password != confirmPassword) return 'Passwords do not match.';
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) return 'Phone number is required.';
    final phoneRegExp = RegExp(r'^\d{10}$');
    if (!phoneRegExp.hasMatch(value)) return 'Invalid phone number format (10 digits required).';
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) return 'Name is required.';
    if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(value)) {
      return 'Name must only contain letters and spaces.';
    }
    return null;
  }
}
