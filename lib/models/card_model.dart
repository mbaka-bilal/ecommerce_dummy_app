enum CardTypes {
  masterCard,
  visaCard,
}

class CardModel {
  CardModel({
    required this.cardNumber,
    required this.cardHolder,
    required this.cardType,
    required this.cvv,
    required this.expiryMonth,
    required this.expiryYear,
});

  final String cardHolder;
  final String cardType;
  final String cvv;
  final String expiryMonth;
  final String expiryYear;
  final String cardNumber;
}