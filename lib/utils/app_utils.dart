extension StringExtension on String {
  ///Extension to convert first letter to upperCase
  String get convertFirstToUpperCase => replaceFirst(
      this[0], this[0].toUpperCase());

  String get hideCardInfo {
    String newString = "";
    for (int i=0;i<length;i++){
      if ((i%4 == 0)){
        newString = "$newString ";
      }
      if (i >= (length - 2)){
        newString = newString + this[i];
      }else{
        newString = "$newString*";
      }


    }
    return newString;
  }
}


// class AppUtils {
//   static String convertFirstToUpperCase(String string){
//     return string.replaceFirst(
//         string[0], string[0].toUpperCase());
//   }
// }

class EmptyFieldException implements Exception {}