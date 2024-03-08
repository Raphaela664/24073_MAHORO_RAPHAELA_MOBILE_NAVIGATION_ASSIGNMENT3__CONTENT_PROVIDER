import 'package:assignment_3/Homepage.dart';
import 'package:assignment_3/pages/authentication/Login_or_registerpage.dart';
import 'package:assignment_3/pages/authentication/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if (snapshot.hasData){
            return Homepage();
          }else{
            return LoginOrSignUpPagState();
          }
        },
      ),
    );
  }
}