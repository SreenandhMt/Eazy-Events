import 'package:event_manager/components/auth/signin_desktop_view.dart';
import 'package:event_manager/components/auth/signin_mobile_view.dart';
import 'package:flutter/material.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (size.width <= 1000) {
      return SigninMobileView(formKey: _formKey);
    }
    return SigninDesktopView(formKey: _formKey);
  }
}
