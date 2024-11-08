import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import '/event_details/view_models/event_view_model.dart';
import '/payment/models/payment_model.dart';
import '/payment/repo/payment_service.dart';

class PaymentViewModel extends ChangeNotifier{
  bool _loading = false;
  bool _paymentLoading = false;
  PaymentSuccess? _successPayment;
  PaymentFailure? _failurePayment;
  String? _paymentAmount;
  String? _clientSecret;

  bool get loading => _loading;
  PaymentSuccess? get successPayment=> _successPayment;
  PaymentFailure? get failurePayment => _failurePayment;
  String? get paymentAmount => _paymentAmount;
  String? get clientSecret => _clientSecret;
  bool get paymentLoading => _paymentLoading;

  setPaymentStatus(PaymentSuccess? successPayment,PaymentFailure? failurePayment)
  {
    _successPayment = successPayment;
    _failurePayment = failurePayment;
  }

  setAmount(String amount)async
  {
    setLoading(true);
    _paymentAmount = amount;
    final ss = await PaymentService.createPaymentIntent(amount, "INR");
    if (ss is String) {
      _clientSecret = ss;
    }
    setLoading(false);
  }

  setLoading(bool loading)async{
    _loading = loading;
    notifyListeners();
  }
  setPaymentLoading(bool loading)async{
    _paymentLoading = loading;
    notifyListeners();
  }

  pay(BuildContext context,unmounte,String price,{required String eventID,required String stock,required String createrID,required String phoneNumber,required String name,required String title})async
  {
    setPaymentLoading(true);
      final ss = await PaymentService.createPaymentIntent(price, "INR");
      if (ss is String) {
        _clientSecret = ss;
    }
    final response = await PaymentService.pay(
        context,
        _clientSecret!,
        price,
        [
          {"productPrice": price, "productName": title, "qty": 1},
        ],
        unmounte);
    if(response is PaymentSuccess)
    {
      EventViewModel eventViewModel = EventViewModel();
      await eventViewModel.createTicket(createrID: createrID,eventID: eventID,name: name,phoneNumber: phoneNumber,stock: stock);
      setPaymentStatus(response, null);
      showMessage(ToastificationStyle.fillColored, ToastificationType.success, "Your payment is successful");
    }
    if(response is PaymentFailure)
    {
      setPaymentStatus(null, response);
      showMessage(ToastificationStyle.fillColored, ToastificationType.success, "Your payment is unsuccessful");
      showMessage(ToastificationStyle.fillColored, ToastificationType.warning, response.errorMessage);
    }
    setPaymentLoading(false);
  }

  showMessage(ToastificationStyle style,ToastificationType type,String text)
  {
    toastification.show(
        title: Text(text),
        style: style,
        type: type,
        autoCloseDuration: const Duration(seconds: 4),
        animationDuration: const Duration(milliseconds: 200),
      );
  }
}