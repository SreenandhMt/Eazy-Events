import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class NetworkConnection {
  static Connectivity _connectivity = Connectivity();
  static bool offline = false;

  static void initializeNetWorkConnection()
  {
    _connectivity.onConnectivityChanged.listen((connectivityResult) async{
      if (connectivityResult.contains(ConnectivityResult.none)) {
        offline = true;
        toastification.show(title: const Text("Please connect to the internet"),autoCloseDuration: const Duration(days: 1),dismissDirection: DismissDirection.none,type: ToastificationType.error,style: ToastificationStyle.flatColored);
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: const Text("Please connect to the internet"),backgroundColor: Colors.red,dismissDirection: DismissDirection.none));
      }else {
        if(offline)
        {
          toastification.show(
              title: const Text("Back to online"),
              dismissDirection: DismissDirection.none,
              autoCloseDuration: const Duration(days: 1),
              type: ToastificationType.success,
              style: ToastificationStyle.flatColored);
          await Future.delayed(
              const Duration(seconds: 1), () => toastification.dismissAll());
        }
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: const Text("Back to online"),backgroundColor: Colors.green));
      }
    });
  }
}