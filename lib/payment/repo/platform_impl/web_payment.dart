import 'package:event_manager/payment/models/payment_model.dart';
import 'package:event_manager/payment/repo/platform_impl/base.dart';
// import 'package:event_manager/payment/repo/platform_impl/stub.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe_web/flutter_stripe_web.dart';


// import '../../../main.dart';

class PaymentImpl extends BasePayment{
  @override
  Widget widget(String clientSecret,BuildContext context)
  {
    return PaymentElement(
      style: CardStyle(backgroundColor: Colors.black),
      autofocus: true,
      enablePostalCode: true,
      onCardChanged: (card) {
        
      },
      clientSecret: clientSecret,
    );
  }

  @override
  Future<Object?> pay(BuildContext context,String clientSecret,String amount,List<dynamic> productItems) async {
    try {
      print("work");
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
            return PaymentSuccess(amount: amount, currency: "INR");
          }else{
            return PaymentFailure(errorMessage: "Payment faild", code: "110");
          }
    } catch (e) {
      return PaymentFailure(errorMessage: "Payment faild: ${e.toString()}", code: "Unnkown");
    }
  }
}