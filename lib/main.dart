import 'package:event_manager/auth/views/auth_route.dart';
import 'package:event_manager/core/theme.dart';
import 'package:event_manager/event_details/view_models/event_view_model.dart';
import 'package:event_manager/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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
