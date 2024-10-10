
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_manager/auth/models/auth_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseFirestore _firestore =FirebaseFirestore.instance;

class AuthService {
  static Future<Object> createAccount({required String email,required String password})async
  {
    try {
      final responce = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      final user =_auth.currentUser!;
      _firestore.collection("profile").doc(user.uid).set({
        "followers":[],
        "following":[],
        "email":user.email!,
        "uid":user.uid,
        "photo":"",
        "name":user.email!.split("@").first
      });
      return responce;
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