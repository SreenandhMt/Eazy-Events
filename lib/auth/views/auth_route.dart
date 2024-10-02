import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:event_manager/auth/view_models/auth_view_model.dart';
import 'package:event_manager/auth/views/login.dart';
import 'package:event_manager/auth/views/signup.dart';

TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController conformPassword = TextEditingController();

class AuthRoute extends StatefulWidget {
  const AuthRoute({super.key});

  @override
  State<AuthRoute> createState() => _AuthRouteState();
}

class _AuthRouteState extends State<AuthRoute> {
  @override
  Widget build(BuildContext context) {
    bool isLoginPage = context.watch<AuthViewModel>().isLoginPage;
    if(isLoginPage)
    {
      return const LoginPage();
    }
    else{
      return const SigninPage();
    }
  }
}

class CustomTextForm extends StatelessWidget {
  const CustomTextForm({
    Key? key,
    required this.text,
    required this.width,
    this.controller,
    this.validator,
  }) : super(key: key);
  final String text;
  final double? width;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
        controller: controller,
        validator: validator,
        decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),hintText: text,hintStyle: GoogleFonts.kanit(fontSize: 14,fontWeight: FontWeight.w500)),
      ),
    );
  }
}
