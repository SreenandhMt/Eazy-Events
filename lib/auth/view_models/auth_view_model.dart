import 'package:event_manager/auth/models/auth_model.dart';
import 'package:event_manager/auth/repo/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class AuthViewModel extends ChangeNotifier {
  bool _loading = false;
  bool _isLoginPage = true;

  bool get loading => _loading;
  bool get isLoginPage => _isLoginPage;

  setPage(bool isLoginPage){
    _isLoginPage = isLoginPage;
    notifyListeners();
  }

  setLoading(bool loading)
  {
    _loading = loading;
    notifyListeners();
  }

  createAccount({required String email,required String password})async{
    setLoading(true);
    final responce =await  AuthService.createAccount(email: email, password: password);
    if(responce is AuthFailure)
    {
      showMessage(ToastificationStyle.fillColored,ToastificationType.error,getFirebaseAuthErrorMessage(responce.code));
    }
    if(responce is UserCredential)
    {
      showMessage(ToastificationStyle.fillColored,ToastificationType.success,"Signup successfully completed");
    }
    setLoading(false);
  }

  signinAccount({required String email,required String password})async
  {
    setLoading(true);
    final responce =await  AuthService.signinAccount(email: email, password: password);
    if(responce is AuthFailure)
    {
      showMessage(ToastificationStyle.fillColored,ToastificationType.error,getFirebaseAuthErrorMessage(responce.code));
    }
    if(responce is UserCredential)
    {
      showMessage(ToastificationStyle.fillColored,ToastificationType.success,"Login successfully completed");
    }
    setLoading(false);
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      showMessage(ToastificationStyle.fillColored,ToastificationType.warning,"Please enter your email");
      return 'Please enter your email';
    }
    // Regular expression for validating email.
    const pattern = r'^[^@]+@[^@]+\.[^@]+';
    final regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      showMessage(ToastificationStyle.fillColored,ToastificationType.warning,"Enter a valid email address");
      return 'Enter a valid email address';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      showMessage(ToastificationStyle.fillColored,ToastificationType.warning,"Please enter your password");
      return 'Please enter your password';
    } else if (value.length < 6) {
      showMessage(ToastificationStyle.fillColored,ToastificationType.warning,"Password must be at least 6 characters long");
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  String? validateSignupEmail(String? value) {
    if (value == null || value.isEmpty) {
      showMessage(ToastificationStyle.fillColored,ToastificationType.warning,"Please enter an email");
      return 'Please enter an email';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      showMessage(ToastificationStyle.fillColored,ToastificationType.warning,"Please enter a valid email");
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validateConfromPassword(String? value,String pass) {
    if (value == null || value.isEmpty) {
      showMessage(ToastificationStyle.fillColored,ToastificationType.warning,"Please enter your conform password");
      return 'Please enter your conform password';
    } else if (pass != value) {
      showMessage(ToastificationStyle.fillColored,ToastificationType.warning,"Passwords do not match");
      return 'Passwords do not match';
    }
    return null;
  }

  String getFirebaseAuthErrorMessage(String errorCode) {
  switch (errorCode) {
    case 'invalid-email':
      return 'The email address is badly formatted.';
    case 'user-disabled':
      return 'This user has been disabled.';
    case 'user-not-found':
      return 'No user found for this email.';
    case 'wrong-password':
      return 'Wrong password provided for this user.';
    case 'email-already-in-use':
      return 'This email address is already in use.';
    case 'operation-not-allowed':
      return 'Email/Password accounts are not enabled.';
    case 'weak-password':
      return 'The password is too weak.';
    case 'invalid-verification-code':
      return 'The verification code is invalid.';
    case 'invalid-verification-id':
      return 'The verification ID is invalid.';
    case 'too-many-requests':
      return 'Too many requests. Try again later.';
    case 'network-request-failed':
      return 'Network error occurred. Please check your connection.';
    default:
      return 'An undefined Error happened.';
  }
  }

  showMessage(ToastificationStyle style,ToastificationType type,String text)
  {
    toastification.show(
        title: Text(text),
        style: style,
        type: type,
        autoCloseDuration: const Duration(seconds: 4),
        animationDuration: const Duration(milliseconds: 200),
      );
  }
}