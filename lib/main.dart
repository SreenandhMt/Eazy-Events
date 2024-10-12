import 'package:event_manager/category_list/view_models/category_view_models.dart';
import 'package:event_manager/core/theme.dart';
import 'package:event_manager/dashboard/view_models/dashboard_view_model.dart';
import 'package:event_manager/event_details/view_models/event_view_model.dart';
import 'package:event_manager/search/view_model/search_view_model.dart';
import 'package:event_manager/firebase_options.dart';
import 'package:event_manager/payment/view_models/payment_view_model.dart';
import 'package:event_manager/tickets/view_model/ticket_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

import 'auth/view_models/auth_view_model.dart';
import 'home/view_models/home_view_model.dart';
import 'page_route.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Stripe.publishableKey = 'pk_test_51PhnltKfAbZCIGAyMIANyBlpFLqnqTVe7GVe3mAEantqP8pRNRibBueekUGuJXOkUdcH8R7dGzsMmdjoWDSS4wWm005dEbUMnE';
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<HomeViewModel>(create: (context)=> HomeViewModel()),
          ChangeNotifierProvider<EventViewModel>(create: (context)=> EventViewModel()),
          ChangeNotifierProvider<AuthViewModel>(create: (context)=> AuthViewModel()),
          ChangeNotifierProvider<DashboardViewModel>(create: (context) => DashboardViewModel(),),
          ChangeNotifierProvider<TicketViewModel>(create: (context) => TicketViewModel(),),
          ChangeNotifierProvider<SearchViewModel>(create: (context) => SearchViewModel(),),
          ChangeNotifierProvider<CategoryViewModels>(create: (context) => CategoryViewModels(),),
          ChangeNotifierProvider<PaymentViewModel>(create: (context) => PaymentViewModel(),)
        ],
        builder: (context,_) {
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              return MaterialApp.router(
                title: 'Book Event',
                darkTheme: AppTheme.darkTheme,
                theme: AppTheme.lightTheme,
                routerConfig: PageRouteGoRouter.goRouter(snapshot.hasData),
              );
            }
          );
        }
      ),
    );
  }
}
