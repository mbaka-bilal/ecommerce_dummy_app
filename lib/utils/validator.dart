class FormValidator {
  static String? validateEmail(String? string) {
    if (string == null || string.trim() == ''){
      return 'Field cannot be empty';
    }
    if (!(RegExp(r"^[a-zA-Z\d.a-zA-Z\d.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z\d]+\.[a-zA-Z]+")
        .hasMatch(string.trim()))){
      return 'Invalid email';
    }
    return null;
  }

  static String? validatePassword(String? string) {
    if (string == null || string.trim() == ""){
      return 'Field cannot be empty';
    }
    return null;
  }

}