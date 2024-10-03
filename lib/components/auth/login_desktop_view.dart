import 'package:event_manager/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:event_manager/core/size.dart';

import '../../auth/view_models/auth_view_model.dart';
import '../../auth/views/auth_route.dart';

class LoginDesktopView extends StatefulWidget {
  const LoginDesktopView({
    Key? key,
    required this.formKey,
  }) : super(key: key);
  final GlobalKey<FormState> formKey;

  @override
  State<LoginDesktopView> createState() => _LoginDesktopViewState();
}

class _LoginDesktopViewState extends State<LoginDesktopView> {
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
              width: (size.width/2)*0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: size.width*0.2,child: Text("Log in",style: GoogleFonts.rowdies(fontSize: 50,fontWeight: FontWeight.w500),)),
                  height30,
                  CustomTextForm(text: "Email",width: size.width*0.2,controller: email,validator: (p0) => authViewModel.validateEmail(p0)),
                  height10,
                  CustomTextForm(text: "Password",width: size.width*0.2,controller: password,validator: (p0) => authViewModel.validatePassword(p0)),
                  height15,
                  MaterialButton(onPressed: (){
                        if(!widget.formKey.currentState!.validate())return;
                        context.read<AuthViewModel>().signinAccount(email: email.text,password: password.text);
                      },minWidth: size.width*0.205,height: 55,color: AppColor.primaryColor,child:authViewModel.loading? const CircularProgressIndicator(): const Text("Create account",style: TextStyle(color: Colors.white),),),
                  height15,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    const Text("No account"),
                    width5,
                    GestureDetector(onTap: () {
                      context.read<AuthViewModel>().setPage(false);
                    },child: const Text("signIn",style: TextStyle(color: Colors.blue),)),
                  ],)
                ],
              ),
            ),
            Image.asset("assets/auth-image.jpg",width: (size.width/2)*1.2,fit: BoxFit.cover,height: double.infinity),
          ],
        ),
      ),
    );
  }
}