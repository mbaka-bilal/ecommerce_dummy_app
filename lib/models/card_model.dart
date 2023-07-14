enum CardTypes {
  masterCard,
  visaCard,
}

enum DebitCardTypes {
  mastercard,
  visa,
  verve,
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

class ResolveCardBin {
  final bool status;
  final String message;
  final ResolveCardData data;

  ResolveCardBin({
    required this.status,
    required this.message,
    required this.data,
  });

  ResolveCardBin.fromJson(Map<String, dynamic> json)
      : status = json["status"],
        message = json["message"],
        data = ResolveCardData.fromJson(json["data"]);
}

class ResolveCardData {
  final String bin;
  final String brand;
  final String subBrand;
  final String countryCode;
  final String countryName;
  final String cardType;
  final String bank;
  final String currency;
  final int? linkedBankId;

  const ResolveCardData({
    required this.bin,
    required this.brand,
    required this.subBrand,
    required this.countryCode,
    required this.cardType,
    required this.bank,
    required this.currency,
    this.linkedBankId,
    required this.countryName,
  });

  ResolveCardData.fromJson(Map<String, dynamic> json)
      : bin = json["bin"],
        brand = json["brand"],
        subBrand = json["sub_brand"],
        countryCode = json["country_code"],
        countryName = json["country_name"],
        cardType = json["card_type"],
        bank = json["bank"],
        currency = json["currency"],
        linkedBankId = json["linked_bank_id"];
}
