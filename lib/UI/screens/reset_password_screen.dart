import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ui_design_with_api/UI/screens/sign_in_screen.dart';
import '../widgets/screen_background.dart';


class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
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
              Text("Set Password", style: textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w500)),

              Text("Minimum length password 8 characters with Letter and number combination",
                style: textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.normal,
                  color: Colors.grey
                ),
              ),

              const SizedBox(height: 24),

              _buildResetPasswordForm(),


              const SizedBox(height: 45),
              _buildCreateSignInSection(),

            ],
          ),
        ),
      ),
    );
  }


  Widget _buildResetPasswordForm(){
    return Column(
      children: [
        TextFormField(
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          decoration: const InputDecoration(
              hintText: "Password"
          ),
        ),

        const SizedBox(height: 14),
        TextFormField(
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          decoration: const InputDecoration(
              hintText: "Confirm Password"
          ),
        ),

        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: _onTapNextButton,
          child: const Text("Confirm")
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


  void _onTapNextButton(){
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const SignInScreen()),
      (_)=> false
    );

  }

  void _onTapSignUp(){
    // TODO: implement signup
    Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInScreen()));
  }


}
