import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
    @EnviedField(varName: 'PAYMENT_API_KEY')
    static const String apikey = _Env.apikey;
    @EnviedField(varName:"PAYMENT_API_URL")
    static const String paymentIntentUrl = _Env.paymentIntentUrl;
    @EnviedField(varName: 'PAYMENT_API_PUBLISHABLE_KEY')
    static const String publishableKey = _Env.publishableKey;
}