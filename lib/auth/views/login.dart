import 'package:event_manager/components/auth/login_desktop_view.dart';
import 'package:event_manager/components/auth/login_mobile_view.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if(size.width<=1000)
    {
      return LoginMobileView(formKey: _formKey);
    }
    return LoginDesktopView(formKey: _formKey);
  }
}