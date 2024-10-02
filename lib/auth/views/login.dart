import 'package:event_manager/home/view_models/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../core/size.dart';
import '../view_models/auth_view_model.dart';
import 'auth_route.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    AuthViewModel authViewModel =context.watch<AuthViewModel>();
    Size size = MediaQuery.of(context).size;
    if(size.width<=1000)
    {
      return Form(
        key: _formKey,
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
                      if(!_formKey.currentState!.validate())return;
                      context.read<AuthViewModel>().signinAccount(email: email.text,password: password.text);
                    },minWidth: size.width*0.705,height: 55,color: Colors.deepOrange[700],child:authViewModel.loading? const CircularProgressIndicator(): const Text("Create account",style: TextStyle(color: Colors.white),),),
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
            ),
      );
    }
    return Form(
      key: _formKey,
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
                        if(!_formKey.currentState!.validate())return;
                        context.read<AuthViewModel>().signinAccount(email: email.text,password: password.text);
                      },minWidth: size.width*0.205,height: 55,color: Colors.deepOrange[700],child:authViewModel.loading? const CircularProgressIndicator(): const Text("Create account",style: TextStyle(color: Colors.white),),),
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