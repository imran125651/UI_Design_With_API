import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../widgets/screen_background.dart';
import 'forgot_password_email_screen.dart';
import 'main_bottom_navbar_screen.dart';
import 'sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Get Started With", style: textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w500)),

              const SizedBox(height: 24),

              _buildSignInForm(),

              const SizedBox(height: 30),
              _buildCreateSignUpSection(),

            ],
          ),
        ),
      ),
    );
  }


  Widget _buildSignInForm(){
    return Column(
      children: [
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
              hintText: "Email"
          ),
        ),

        const SizedBox(height: 8),
        TextFormField(
          obscureText: true,
          decoration: const InputDecoration(
              hintText: "Password"
          ),
        ),

        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: _onTapNextButton,
          child: const Icon(Icons.arrow_circle_right_outlined)
        ),
      ],
    );
  }

  Widget _buildCreateSignUpSection(){
    return Center(
      child: Column(
        children: [
          TextButton(
            onPressed: _onTapForgetPassword,
            child: const Text("Forget Password?", style: TextStyle(color: Colors.grey),)
          ),

          RichText(
            text: TextSpan(
              text: "Don't have an account? ",
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 14
              ),
              children: [
                TextSpan(
                  recognizer: TapGestureRecognizer()..onTap = _onTapSignUp,
                  text: "Sign up",
                  style: const TextStyle(color: Colors.blue),
                )
              ]
            ),
          )
        ],
      ),
    );
  }


  void _onTapForgetPassword(){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const ForgotPasswordEmailScreen()), (route) => false,);
  }


  void _onTapNextButton(){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const MainBottomNavbarScreen()), (route) => false,);
  }

  void _onTapSignUp(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
  }


}
