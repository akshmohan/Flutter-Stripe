// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter_stripe_app/constants/api_keys.dart';

class StripeService {
  StripeService._();

  static final StripeService _instance = StripeService._();

  Future<void> makePayment() async {
    try {
      String? result = await _createPaymentIntent(10, "USD");
    } catch (e) {
      print(e);
    }
  }

  Future<String?> _createPaymentIntent(int amount, String currency) async {
    try {
      final Dio dio = Dio();

      Map<String, dynamic> data = {
        'amount': _calculateAmount(amount),
        'currency': currency,
      };

      var response = await dio.post(
        'https://api.stripe.com/v1/payment_intents',
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authoriation": "Bearer $stripeSecretKey",
            "Content-Type": "application/x-www-form-urlencoded"
          },
        ),
      );  

      if(response.data != null) {
        print(response.data);
       return "";
      }
       return null;
    } catch (e) {
      print(e);
    }
    return null;
  }

  String _calculateAmount(int amount) {
    final calculatedAmount = amount * 100;
    return calculatedAmount.toString();
  }
}
