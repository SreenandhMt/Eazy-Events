class PaymentSuccess {
  final String amount;
  final String currency;

  PaymentSuccess({required this.amount, required this.currency});
}

class PaymentFailure {
  String errorMessage;
  String code;

  PaymentFailure({required this.errorMessage,required this.code});
}
