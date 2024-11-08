import 'package:flutter/material.dart';

abstract class BasePayment {
  Future<Object?> pay(BuildContext context,String clientSecret,String amount,List<dynamic> productItems);
  Widget widget(String clientSecret,BuildContext context);
}