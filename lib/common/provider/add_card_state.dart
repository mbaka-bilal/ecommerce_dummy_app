import 'package:ecommerce_dummy_app/models/card_model.dart';
import 'package:ecommerce_dummy_app/utils/constants.dart';
import 'package:equatable/equatable.dart';

class AddCardState extends Equatable {
  final RequestStatus requestStatus;
  final String cardNumber;
  final String expirationMonth;
  final String expirationyear;
  final String cvv;
  final String cardHolderName;

  const AddCardState({
    this.requestStatus = RequestStatus.initial,
    this.cardNumber = "",
    this.expirationMonth = "",
    this.expirationyear = "",
    this.cvv = "",
    this.cardHolderName = "",
  });

  AddCardState copyWith({
    required RequestStatus requestStatus,
     String? cardNumber,
     String? expirationMonth,
     String? expirationyear,
     String? cvv,
     String? cardHolderName,
  }) {
    return AddCardState(
        requestStatus: requestStatus,
        cardNumber: cardNumber ?? this.cardNumber,
        expirationMonth: expirationMonth ?? this.expirationMonth,
        expirationyear: expirationyear ?? this.expirationyear,
        cvv: cvv ?? this.cvv,
        cardHolderName: cardHolderName ?? this.cardHolderName);
  }

  @override
  List<Object?> get props => [
        requestStatus,
        cardNumber,
        cvv,
        expirationMonth,
        expirationyear,
        cardHolderName
      ];
}
