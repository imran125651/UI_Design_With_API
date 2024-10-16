import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ui_design_with_api/UI/controller/auth_controller.dart';
import 'package:ui_design_with_api/UI/screens/main_bottom_navbar_screen.dart';
import 'package:ui_design_with_api/UI/screens/sign_in_screen.dart';
import '../utils/AssetsPath.dart';
import '../widgets/screen_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async{
    Future.delayed(const Duration(seconds: 2), () async{
      await AuthController.getAccessToken();
      if(AuthController.isLoggedIn()){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainBottomNavbarScreen()));
      }
      else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignInScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child: Center(child: SvgPicture.asset(AssetsPath.logoSvg))
      )
    );
  }
}
