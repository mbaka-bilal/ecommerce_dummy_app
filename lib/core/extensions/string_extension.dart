extension StringExtension on String {
  String firstLetterCapitalized() => this[0].toUpperCase() + substring(1);
}
