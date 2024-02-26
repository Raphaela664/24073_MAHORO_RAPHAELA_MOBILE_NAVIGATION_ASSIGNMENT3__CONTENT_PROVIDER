import 'package:assignment_3/pages/authentication/login_page.dart';
import 'package:assignment_3/components/button.dart';
import 'package:assignment_3/components/square_tile.dart';
import 'package:assignment_3/components/textfield.dart';
import 'package:flutter/material.dart';

class signupPage extends StatelessWidget {
  signupPage({super.key});


  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
 


  // sign user in method
  void signUserUp() {}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              // logo
              const Icon(
                Icons.lock,
                size: 85,
              ),

              const SizedBox(height: 30),

              // Create account
              Text(
                'Create Account',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 20),
              // email textfield
              Text_field(
                controller: emailController,
                hintText: 'email',
                obscureText: false,
              ),
              const SizedBox(height: 10),

              // username textfield
              Text_field(
                controller: usernameController,
                hintText: 'Username',
                obscureText: false,
              ),

              const SizedBox(height: 10),

              // password textfield
              Text_field(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),
              
          

              const SizedBox(height: 20),

              // sign in button
              MyButton(
                onTap: signUserUp,
                buttonText: 'Sign Up',
                
              ),

              const SizedBox(height: 15),

              // or continue with
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

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  // google button
                  SquareTile(imagePath: 'images/google.png'),

                ],
              ),

              const SizedBox(height: 15),

           
              
            ],
          ),
        ),

        )
        
      ),
    );
  }
}