import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ui_design_with_api/UI/screens/sign_in_screen.dart';

import '../widgets/screen_background.dart';
import 'forgot_password_otp_screen.dart';
import 'sign_up_screen.dart';

class ForgotPasswordEmailScreen extends StatefulWidget {
  const ForgotPasswordEmailScreen({super.key});

  @override
  State<ForgotPasswordEmailScreen> createState() => _ForgotPasswordEmailScreenState();
}

class _ForgotPasswordEmailScreenState extends State<ForgotPasswordEmailScreen> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Your Email Address", style: textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w500)),

              Text("A 6 digits verifications otp will be sent to your email address",
                style: textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.normal,
                  color: Colors.grey
                ),
              ),

              const SizedBox(height: 24),

              _buildEmailVerifyEmailForm(),


              const SizedBox(height: 45),
              _buildCreateSignInSection(),

            ],
          ),
        ),
      ),
    );
  }


  Widget _buildEmailVerifyEmailForm(){
    return Column(
      children: [
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
              hintText: "Email"
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

  Widget _buildCreateSignInSection(){
    return Center(
      child: Column(
        children: [

          RichText(
            text: TextSpan(
              text: "Have account? ",
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 14
              ),
              children: [
                TextSpan(
                  recognizer: TapGestureRecognizer()..onTap = _onTapSignUp,
                  text: "Sign In",
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
    // TODO: implement forget password
  }


  void _onTapNextButton(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPasswordOTPScreen()));

  }

  void _onTapSignUp(){
    // TODO: implement signup
    Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInScreen()));
  }


}
