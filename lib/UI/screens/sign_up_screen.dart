import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ui_design_with_api/UI/screens/sign_in_screen.dart';
import 'package:ui_design_with_api/UI/widgets/snack_bar_message.dart';
import 'package:ui_design_with_api/data/models/network_response.dart';
import 'package:ui_design_with_api/data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/center_circular_progress_indicator.dart';
import '../widgets/screen_background.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isProgress = false;


  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


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
    return Form(
      key: _formState,
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
                hintText: "Email"
            ),
            validator: (value){
              if(value?.isEmpty ?? true){
                return "Enter valid email";
              }
              return null;
            },
          ),

          const SizedBox(height: 8),
          TextFormField(
            controller: _firstNameController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(
                hintText: "First Name"
            ),
            validator: (value){
              if(value?.isEmpty ?? true){
                return "Enter valid first name";
              }
              return null;
            },
          ),

          const SizedBox(height: 8),
          TextFormField(
            controller: _lastNameController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(
                hintText: "Last Name"
            ),
            validator: (value){
              if(value?.isEmpty ?? true){
                return "Enter valid last name";
              }
              return null;
            },
          ),

          const SizedBox(height: 8),
          TextFormField(
            controller: _mobileController,
            keyboardType: TextInputType.phone,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(
                hintText: "Mobile"
            ),
            validator: (value){
              if(value?.isEmpty ?? true){
                return "Enter valid mobile number";
              }
              return null;
            },
          ),

          const SizedBox(height: 8),
          TextFormField(
            controller: _passwordController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            obscureText: true,
            decoration: const InputDecoration(
                hintText: "Password"
            ),
            validator: (value){
              if(value?.isEmpty ?? true){
                return "Enter your password";
              }
              if(value!.length < 6){
                return "Enter valid minimum 6 characters";
              }
              return null;
            },
          ),

          const SizedBox(height: 24),
          Visibility(
            visible: _isProgress == false,
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


  void _onTapNextButton() async{

    if(!_formState.currentState!.validate()){
      return;
    }
    await _signUp();
  }

  void _onTapSignIn(){
    // TODO: implement signup
    Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInScreen()));
  }

  Future<void> _signUp() async{
    setState(() {
      _isProgress = true;
    });
    Map<String, dynamic> inputJson = {
      "email": _emailController.text.trim(),
      "firstName": _firstNameController.text.trim(),
      "lastName": _lastNameController.text.trim(),
      "mobile": _mobileController.text.trim(),
      "password": _passwordController.text
    };
    NetworkResponse networkResponse = await NetworkCaller.postRequest(
      url: Urls.registration,
      body: inputJson,
    );
    setState(() {
      _isProgress = false;
    });

    if(networkResponse.isSuccess){
      showSnackBarMessage(context, "New user created");
      _clearTextFields();
      Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInScreen()));
    }
    else{
      showSnackBarMessage(context, networkResponse.errorMessage, true);
    }
  }

  void _clearTextFields(){
    _emailController.clear();
    _firstNameController.clear();
    _lastNameController.clear();
    _mobileController.clear();
    _passwordController.clear();
  }
  

}
