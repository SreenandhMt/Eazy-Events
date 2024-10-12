import 'dart:convert';

import 'package:event_manager/payment/models/payment_model.dart';
import 'package:flutter_stripe_web/flutter_stripe_web.dart';
import 'package:http/http.dart' as http;

class PaymentService {
  static Future<String?> createPaymentIntent(String amount,String currency) async {
    try {
      final url = Uri.parse('https://api.stripe.com/v1/payment_intents');
      final response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer sk_test_51PhnltKfAbZCIGAymrPA1Z12Iq9RLsbs8DBIzmCxbepLJFCpw3pqn8LmI1EaijAQw3mG5x4rRr3Cdnrrp94dnpvZ00GE00d0Zq",
          "Content-Type": 'application/x-www-form-urlencoded'
        },
        body: {
          'amount': "$amount",
          'currency': 'usd',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
          return data['client_secret'];
      } else {
        return null;
        // throw Exception('Failed to create payment intent');
      }
    } catch (e) {
      return null;
      //  throw Exception('Error creating payment intent: ${e.toString()}');
    }
  }
  static Future<Object> pay(String amount,String currency,String clientSecret) async {
    try {
      // if(clientSecret==null)return PaymentFailure(errorMessage: "Failed to create payment intent", code: "109");
          final paymentResult = await WebStripe.instance.confirmPaymentElement(
            const ConfirmPaymentElementOptions(
              redirect: PaymentConfirmationRedirect.ifRequired,
              confirmParams: ConfirmPaymentParams(
                return_url: "",
              ),
            ),
          );

          if (paymentResult.status == PaymentIntentsStatus.Succeeded) {
            return PaymentSuccess(amount: amount, currency: currency);
          }else{
            return PaymentFailure(errorMessage: "Payment faild", code: "110");
          }
    } catch (e) {
      return PaymentFailure(errorMessage: "Payment faild: ${e.toString()}", code: "Unnkown");
    }
  }
}
