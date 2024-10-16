import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ui_design_with_api/UI/controller/auth_controller.dart';
import 'package:ui_design_with_api/UI/widgets/center_circular_progress_indicator.dart';
import 'package:ui_design_with_api/UI/widgets/snack_bar_message.dart';
import 'package:ui_design_with_api/data/models/network_response.dart';
import 'package:ui_design_with_api/data/services/network_caller.dart';
import 'package:ui_design_with_api/data/utils/urls.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoginProgress = false;


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(
                hintText: "Email"
            ),
            validator: (value){
              if(value?.isEmpty ?? true){
                return "Please input you email";
              }
              if(!value!.contains("@")){
                return "Please enter a valid email";
              }
              return null;
            },
          ),

          const SizedBox(height: 8),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(
                hintText: "Password"
            ),
            validator: (value){
              if(value?.isEmpty ?? true){
                return "Please input you password";
              }
              return null;
            },
          ),

          const SizedBox(height: 24),
          Visibility(
            visible: !_isLoginProgress,
            replacement: const CenterCircularProgressIndicator(),
            child: ElevatedButton(
              onPressed: _onTapNextButton,
              child: const Icon(Icons.arrow_circle_right_outlined)
            ),
          ),
        ],
      ),
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
    FocusScope.of(context).unfocus();
    if(!_formKey.currentState!.validate()) return;

    _signIn();
  }

  Future<void> _signIn() async{
    setState(() {
      _isLoginProgress = true;
    });

    final NetworkResponse networkResponse = await NetworkCaller.postRequest(
        url: Urls.login,
        body: {
          "email": _emailController.text.trim(),
          "password": _passwordController.text
        }
    );

    setState(() {
      _isLoginProgress = false;
    });

    if(networkResponse.isSuccess){
      await AuthController.saveAccessToken(networkResponse.responseData["token"]);

      showSnackBarMessage(context, "Login Successful");
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const MainBottomNavbarScreen()), (route) => false,);
    }
    else{
      showSnackBarMessage(context, networkResponse.errorMessage, true);
    }
  }

  void _onTapSignUp(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
  }


}
