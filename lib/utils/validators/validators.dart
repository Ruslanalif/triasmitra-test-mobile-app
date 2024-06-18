
class MainValidator{

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    String pattern =
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? isRequired(String? value, String fieldName){
    if(value == null || value.isEmpty){
      return '$fieldName is Required';
    }

    return null;

  }

  static String? phoneNumberValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    String pattern = r'^[0-9]+$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid phone number';
    }
    if (value.length < 10 || value.length > 15) {
      return 'Phone number must be between 10 and 15 digits';
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  static String? nikValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'NIK is required';
    }
    String pattern = r'^[0-9]{16}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'NIK must be exactly 16 digits';
    }
    return null;
  }
}