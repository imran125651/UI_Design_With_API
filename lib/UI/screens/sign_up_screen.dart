import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ui_design_with_api/UI/screens/sign_in_screen.dart';
import '../widgets/screen_background.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 82),
                Text("Join With US", style: textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w500)),

                const SizedBox(height: 24),

                _buildSignUpForm(),


                const SizedBox(height: 30),
                _buildCreateSignInSection(),

              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildSignUpForm(){
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
          decoration: const InputDecoration(
              hintText: "First Name"
          ),
        ),

        const SizedBox(height: 8),
        TextFormField(
          decoration: const InputDecoration(
              hintText: "Last Name"
          ),
        ),

        const SizedBox(height: 8),
        TextFormField(
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
              hintText: "Mobile"
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

  Widget _buildCreateSignInSection(){
    return Center(
      child: Column(
        children: [

          RichText(
            text: TextSpan(
              text: "Have an account? ",
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 14
              ),
              children: [
                TextSpan(
                  recognizer: TapGestureRecognizer()..onTap = _onTapSignIn,
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
    // TODO: implement login

  }

  void _onTapSignIn(){
    // TODO: implement signup
    Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInScreen()));
  }


}
