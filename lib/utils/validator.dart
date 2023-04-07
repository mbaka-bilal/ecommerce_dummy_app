class FormValidator {
  static String? validateEmail(String? string) {
    if (string == null || string.trim() == ''){
      return "Field cannot be empty";
    }
    if (!(RegExp(r"^[a-zA-Z\d.a-zA-Z\d.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z\d]+\.[a-zA-Z]+")
        .hasMatch(string.trim()))){
      return " invalid email";
    }
    return null;
  }

  static String? validateName(String? string) {
    if (string == null || string.trim() == ""){
      return 'Field cannot be empty ';
    }
    if (!RegExp(r"[a-zA-Z]+$").hasMatch(string.trim())){
      return "Not a valid name";
    }
    return null;
  }


  static String? validatePassword(String? string) {
    if (string == null || string.trim() == ""){
      return 'Field cannot be empty';
    }
    if (string.trim().length < 6){
      return 'Password to short';
    }
    return null;
  }

}