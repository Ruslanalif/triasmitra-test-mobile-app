
class MainValidator{

  static String? validateEmail(String? value){
    if(value == null || value.isEmpty){
      return 'Email is Required';
    }

    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2.4}$');

    if(!emailRegExp.hasMatch(value)){
      return 'Invalid Email Address!';
    }
    return null;

  }

  static String? isRequired(String? value, String fieldName){
    if(value == null || value.isEmpty){
      return '$fieldName is Required';
    }

    return null;

  }
}