import 'package:assignment_3/pages/authentication/login_page.dart';
import 'package:assignment_3/pages/authentication/signup_page.dart';
import 'package:flutter/material.dart';

class LoginOrSignUpPagState extends StatefulWidget {
  const LoginOrSignUpPagState({super.key});

  @override
  State<LoginOrSignUpPagState> createState() => _LoginOrSignUpPagStateState();
}

class _LoginOrSignUpPagStateState extends State<LoginOrSignUpPagState> {
  bool showLoginPage = true;
  void togglePages (){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showLoginPage){
     return LoginPage(
      onTap: togglePages,
     );
    }else{
      return SignUpPage(
        onTap:  togglePages
      );
    }
  }
}