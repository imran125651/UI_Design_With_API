import 'package:flutter/material.dart';
import 'package:ui_design_with_api/UI/controller/auth_controller.dart';
import '../screens/profile_screen.dart';
import '../screens/sign_in_screen.dart';
import '../utils/app_color.dart';

class TaskMangerAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TaskMangerAppBar({
    super.key,
    this.isOpenProfileScreen = false,
  });

  final bool isOpenProfileScreen;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.themeColor,
      centerTitle: false,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      title: GestureDetector(
        onTap: () {
          if(isOpenProfileScreen){
            return;
          }
          Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
        },
        child: Row(
          children: [
            const CircleAvatar(
              child: Icon(Icons.person),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Imran Hossain",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.white)),
                  Text("imran125651@gmail.com",
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: Colors.white)),
                ],
              ),
            ),
            IconButton(
              onPressed: () async{
                await AuthController.clearUserData();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignInScreen(),
                    ),
                    (_) => false);
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
