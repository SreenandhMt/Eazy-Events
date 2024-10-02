
import 'dart:developer';

import 'package:event_manager/auth/models/auth_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class AuthService {
  static Future<Object> createAccount({required String email,required String password})async
  {
    try {
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch(e)
    {
      return AuthFailure(message: e.message!, code: e.code);
    }
    catch (e) {
      return AuthFailure(message: e.toString(), code: "unkown");
    }
  }
  static Future<Object> signinAccount({required String email,required String password})async
  {
    try {
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch(e)
    {
      log(e.code);
      return AuthFailure(message: e.message!, code: e.code);
    }
    catch (e) {
      return AuthFailure(message: e.toString(), code: "unkown");
    }
  }
}