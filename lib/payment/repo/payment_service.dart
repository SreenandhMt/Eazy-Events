import 'dart:convert';
import 'package:event_manager/env/env.dart';
import 'package:event_manager/payment/models/payment_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'platform_impl/imp.dart';


class PaymentService {
  
  static Future<Object?> pay(BuildContext context,String clientSecret,String amount,List<dynamic> productItems,unmounte) async {
    try {
      if(kIsWeb)
      {
        return PaymentImpl().pay(context, clientSecret, amount, productItems);
      }else{
        return PaymentImpl().pay(context, clientSecret, amount, productItems);
      }
    } catch (e) {
      return PaymentFailure(errorMessage: "Payment faild: ${e.toString()}", code: "Unnkown");
    }
  }
  static Future<String?> createPaymentIntent(String amount,String currency) async {
    try {
      final url = Uri.parse(Env.paymentIntentUrl);
      final response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer ${Env.apikey}",
          "Content-Type": 'application/x-www-form-urlencoded'
        },
        body: {
          'amount': (int.parse(amount)*100).round().toString(),
          'currency': 'inr',
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
}
