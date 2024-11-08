import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../auth/view_models/auth_view_model.dart';
import '../../auth/views/auth_route.dart';
import '../../core/colors.dart';
import '../../core/size.dart';

class LoginMobileView extends StatefulWidget {
  const LoginMobileView({
    super.key,
    required this.formKey,
  });
  final GlobalKey<FormState> formKey;
  @override
  State<LoginMobileView> createState() => _LoginMobileViewState();
}

class _LoginMobileViewState extends State<LoginMobileView> {
  @override
  Widget build(BuildContext context) {
    AuthViewModel authViewModel =context.watch<AuthViewModel>();
    Size size = MediaQuery.of(context).size;
    return Form(
        key: widget.formKey,
        child: Scaffold(
        body: Form(
          child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Log in",style: GoogleFonts.rowdies(fontSize: 50,fontWeight: FontWeight.w500),),
                    height30,
                    CustomTextForm(text: "Email",width: size.width*0.7,controller: email,validator: (p0) => authViewModel.validateEmail(p0),),
                    height10,
                    CustomTextForm(text: "Password",width: size.width*0.7,controller: password,validator: (p0) => authViewModel.validatePassword(p0)),
                    height15,
                    MaterialButton(onPressed: (){
                      if(!widget.formKey.currentState!.validate())return;
                      context.read<AuthViewModel>().signinAccount(email: email.text,password: password.text);
                    },minWidth: size.width*0.705,height: 55,color: AppColor.primaryColor,child:authViewModel.loading? const CircularProgressIndicator(): const Text("SignIn",style: TextStyle(color: Colors.white),),),
                    height15,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      const Text("No account"),
                      width5,
                      GestureDetector(onTap: () {
                        
                        context.read<AuthViewModel>().setPage(false);
                      },child: const Text("signUp",style: TextStyle(color: Colors.blue),)),
                    ],)
                  ],
                ),
        ),
            ),
      );
  }
}