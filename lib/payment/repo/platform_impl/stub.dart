
import 'package:event_manager/payment/repo/platform_impl/base.dart';
import 'package:flutter/material.dart';

class PaymentImpl extends BasePayment{
  @override
  Future<Object?> pay(BuildContext context,String clientSecret,String amount,List<dynamic> productItems) {
    throw Exception("Stub implementation");
  }
  
  @override
  Widget widget(String clientSecret,BuildContext context) {
    throw Exception("Stub implementation");
  }
}