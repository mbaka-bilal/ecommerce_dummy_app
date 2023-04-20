extension StringExtension on String {
  ///Extension to convert first letter to upperCase
  String get convertFirstToUpperCase => replaceFirst(
      this[0], this[0].toUpperCase());
}


// class AppUtils {
//   static String convertFirstToUpperCase(String string){
//     return string.replaceFirst(
//         string[0], string[0].toUpperCase());
//   }
// }