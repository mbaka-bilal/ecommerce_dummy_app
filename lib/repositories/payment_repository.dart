import 'package:http/http.dart' as http;

import '../utils/constants.dart';

class PaymentRepository {
  ///Handle payment
  ///
  ///

  Future<http.Response> checkCard(String cardNumber) async {
    final url = Uri.parse(resolveCardBin(cardNumber));
    final response = await http.get(url);
    return response;
  }
}