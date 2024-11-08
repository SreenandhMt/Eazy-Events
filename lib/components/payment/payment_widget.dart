import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../../payment/repo/platform_impl/imp.dart';

class PlatformPaymentElement extends StatelessWidget {
  const PlatformPaymentElement({super.key, required this.clientSecret});

  final String? clientSecret;

  @override
  Widget build(BuildContext context) {
    if(kIsWeb)
    {
      return PaymentImpl().widget(clientSecret??"",context);
    }
    return const SizedBox();
  }
}
