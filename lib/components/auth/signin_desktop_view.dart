import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../auth/view_models/auth_view_model.dart';
import '../../auth/views/auth_route.dart';
import '../../core/colors.dart';
import '../../core/size.dart';

class SigninDesktopView extends StatefulWidget {
  const SigninDesktopView({
    super.key,
    required this.formKey,
  });
  final GlobalKey<FormState> formKey;

  @override
  State<SigninDesktopView> createState() => _SigninDesktopViewState();
}

class _SigninDesktopViewState extends State<SigninDesktopView> {
  @override
  Widget build(BuildContext context) {
    AuthViewModel authViewModel =context.watch<AuthViewModel>();
    Size size = MediaQuery.of(context).size;
    return Form(
      key: widget.formKey,
      child: Scaffold(
        body: Row(
          children: [
            SizedBox(
              width: (size.width / 2) * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: size.width * 0.2,
                      child: Text(
                        "Create an account",
                        style: GoogleFonts.rowdies(
                            fontSize: 50, fontWeight: FontWeight.w500),
                      )),
                  height30,
                  CustomTextForm(
                    text: "Email",
                    width: size.width * 0.2,
                    controller: email,
                    validator: (p0) => authViewModel.validateSignupEmail(p0),
                  ),
                  height10,
                  CustomTextForm(
                    text: "Password",
                    width: size.width * 0.2,
                    controller: password,
                    validator: (p0) => authViewModel.validatePassword(p0),
                  ),
                  height10,
                  CustomTextForm(
                    text: "Conform Password",
                    width: size.width * 0.2,
                    controller: conformPassword,
                    validator: (p0) => authViewModel.validateConfromPassword(
                        p0, password.text),
                  ),
                  height15,
                  MaterialButton(
                    onPressed: () {
                      if (!widget.formKey.currentState!.validate()) return;
                      context.read<AuthViewModel>().createAccount(
                          email: email.text, password: password.text);
                    },
                    minWidth: size.width * 0.205,
                    height: 55,
                    color: AppColor.primaryColor,
                    child: authViewModel.loading
                        ? const CircularProgressIndicator()
                        : const Text(
                            "Create account",
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                  height15,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Account already exists"),
                      width5,
                      GestureDetector(
                          onTap: () {
                            context.read<AuthViewModel>().setPage(true);
                          },
                          child: const Text(
                            "SignIn",
                            style: TextStyle(color: Colors.blue),
                          )),
                    ],
                  )
                ],
              ),
            ),
            Image.asset("assets/auth-image2.jpg",
                width: (size.width / 2) * 1.2,
                fit: BoxFit.cover,
                height: double.infinity),
          ],
        ),
      ),
    );
  }
}