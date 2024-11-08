import 'dart:developer';

import 'package:event_manager/payment/repo/platform_impl/base.dart';
import 'package:event_manager/utils/dark_check.dart';
// import 'package:event_manager/payment/repo/platform_impl/stub.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '../../models/payment_model.dart';

class PaymentImpl extends BasePayment{
  static PaymentIntent? paymentIntent;
  
  @override
  Widget widget(String clientSecret,BuildContext context) {
    // TODO: implement widget
    throw UnimplementedError();
  }

  @override
  Future<Object?> pay(BuildContext context,String clientSecret,String amount,List<dynamic> productItems) async {
    await Stripe.instance
        .initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
                paymentIntentClientSecret: clientSecret,
                merchantDisplayName: "ffv",
                style: isDarkTheme(context)? ThemeMode.dark:ThemeMode.light));

    return await displayPaymentSheet(context,amount);
  }

  Future<dynamic> displayPaymentSheet(BuildContext context,String amount) async {
    try {
      log("log -1");
      return await Stripe.instance.presentPaymentSheet().then((value) {
        log("log -2");
        showDialog(
            context: context,
            builder: (_) => const AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 100.0,
                      ),
                      SizedBox(height: 10.0),
                      Text("Payment Successful!"),
                    ],
                  ),
                ));
                paymentIntent = null;
        return PaymentSuccess(amount: amount, currency: "INR");
      }).onError((error, stackTrace) {
        log("log -2");
        log(error.toString());
        throw Exception(error);
      });
    } on StripeException catch (e) {
      log('Error is:---> $e');
      const AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                Text("Payment Failed"),
              ],
            ),
          ],
        ),
      );
      return PaymentFailure(errorMessage: "Payment Canceled", code: "120");
    } catch (e) {
      log('$e');
    }
  } 
}