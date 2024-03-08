import 'package:assignment_3/components/button.dart';
import 'package:assignment_3/components/square_tile.dart';
import 'package:assignment_3/components/textfield.dart';
import 'package:assignment_3/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'signup_page.dart';

class SignUpPage extends StatefulWidget {
  final Function()? onTap;
  const SignUpPage({super.key, required this.onTap});
  

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signUserUp() async{

    showDialog(context: context, builder: (context){
      return Center(
        child: CircularProgressIndicator()
      );
    });
    try{
      
    if(passwordController.text == confirmPasswordController.text ){
      await  FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text
    );
    }else{
      ShowErrorMessage("Passwords don't match");
    }
    Navigator.pop(context);
    
    }on FirebaseAuthException  catch(e) {
      Navigator.pop(context);
      ShowErrorMessage(e.code);
    }
  

  }
  
  void ShowErrorMessage(String Message){
    showDialog(context: context, builder: (context){

      return AlertDialog(
        backgroundColor: Colors.orange,
        title: Center(
          child: Text(
            Message,
          style: TextStyle(color: Colors.white)
          ),
          
          ),
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              const Icon(
                Icons.lock,
                size: 85,
              ),
              const SizedBox(height: 30),
              Text(
                'Create an Account',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 30),
              Text_field(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
              ),
              const SizedBox(height: 20),
              Text_field(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),
              const SizedBox(height: 20),
              Text_field(
                controller: confirmPasswordController,
                hintText: 'Confirm password',
                obscureText: true,
              ),
          
              const SizedBox(height: 15),
              MyButton(
                onTap: signUserUp,
                buttonText: 'Sign Up',
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7.0),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SquareTile(
                    imagePath: 'images/google.png',
                    onTap: ()=> Auth_Service().signInWithGoogle(),
                    ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Alredy have an account?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      'Login now',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        )
        
      ),
    );
  }
}


