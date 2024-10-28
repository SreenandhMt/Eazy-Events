import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
    final response = await PaymentService.createPaymentIntent(amount, "INR");
    if(response is String)
    {
      _clientSecret = response;
    }else{
      _paymentAmount = null;
      _clientSecret = null;
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

  pay(BuildContext context,{required String eventID,required String stock,required String createrID,required String phoneNumber,required String name})async
  {
    setPaymentLoading(true);
    if(paymentAmount==null||_clientSecret==null)
    {
      setPaymentStatus(null, PaymentFailure(errorMessage: "Dont Refresh the page", code: "100"));
      context.pop();
      setLoading(false);
      return;
    }
    final response = await PaymentService.pay(paymentAmount!, "INR",_clientSecret!);
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