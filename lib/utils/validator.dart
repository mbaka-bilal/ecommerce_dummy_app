class FormValidator {
  static String? validateEmail(String? string) {
    if (string == null || string.trim() == ''){
      return " ";
    }
    if (!(RegExp(r"^[a-zA-Z\d.a-zA-Z\d.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z\d]+\.[a-zA-Z]+")
        .hasMatch(string.trim()))){
      return " ";
    }
    return null;
  }

  static String? validatePassword(String? string) {
    if (string == null || string.trim() == ""){
      return ' ';
    }
    return null;
  }

}