import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:ui_design_with_api/UI/screens/reset_password_screen.dart';
import 'package:ui_design_with_api/UI/screens/sign_in_screen.dart';

import '../widgets/screen_background.dart';
import 'sign_up_screen.dart';

class ForgotPasswordOTPScreen extends StatefulWidget {
  const ForgotPasswordOTPScreen({super.key});

  @override
  State<ForgotPasswordOTPScreen> createState() => _ForgotPasswordOTPScreenState();
}

class _ForgotPasswordOTPScreenState extends State<ForgotPasswordOTPScreen> {
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
              Text("Pin verifications", style: textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w500)),

              Text("A 6 digits verifications otp will be sent to your email address",
                style: textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.normal,
                  color: Colors.grey
                ),
              ),

              const SizedBox(height: 24),

              PinCodeTextField(
                length: 6,
                obscureText: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 45,
                  inactiveFillColor: Colors.transparent,
                  selectedFillColor: Colors.transparent,
                  selectedColor: Colors.green,
                  activeFillColor: Colors.white,
                ),
                cursorColor: Colors.black,
                animationDuration: const Duration(milliseconds: 100),
                backgroundColor: Colors.transparent,
                appContext: context,
              ),

              const SizedBox(height: 10),
              _buildEmailVerifyOTPForm(),

              const SizedBox(height: 45),
              _buildCreateSignInSection(),

            ],
          ),
        ),
      ),
    );
  }


  Widget _buildEmailVerifyOTPForm(){
    return ElevatedButton(
        onPressed: _onTapNextButton,
        child: const Text("Verify")
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
    // TODO: implement login
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ResetPasswordScreen(),),
    );
  }

  void _onTapSignUp(){
    // TODO: implement signup
    Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInScreen()));
  }


}
