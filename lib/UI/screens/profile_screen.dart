import 'package:flutter/material.dart';

import '../widgets/screen_background.dart';
import '../widgets/task_manager_app_bar.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const TaskMangerAppBar(
        isOpenProfileScreen: true,
      ),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 48),
                Text("Update Profile", style: textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w500)),


                const SizedBox(height: 40),
                _buildUpdateProfileForm(),


              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildUpdateProfileForm(){
    return Column(
      children: [
        _buildPhotoPicker(),

        const SizedBox(height: 10),
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
              hintText: "Email"
          ),
        ),

        const SizedBox(height: 10),
        TextFormField(
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
              hintText: "First Name"
          ),
        ),

        const SizedBox(height: 10),
        TextFormField(
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
              hintText: "Last Name"
          ),
        ),

        const SizedBox(height: 10),
        TextFormField(
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
              hintText: "Mobile"
          ),
        ),

        const SizedBox(height: 10),
        TextFormField(
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          decoration: const InputDecoration(
              hintText: "Password"
          ),
        ),

        const SizedBox(height: 15),
        ElevatedButton(
            onPressed: (){

            },
            child: const Icon(Icons.arrow_circle_right_outlined)
        )
      ],
    );
  }

  Widget _buildPhotoPicker(){
    return SizedBox(
      height: 55,
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
                borderRadius: const BorderRadius.horizontal(left: Radius.circular(5))
              ),
              alignment: Alignment.center,
              child: const Text("Photos", style: TextStyle(fontSize: 16, color: Colors.white)),
            )
          ),


          Expanded(
            flex: 7,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: const BorderRadius.horizontal(right: Radius.circular(5))
              ),
              alignment: Alignment.centerLeft,
              child: const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text("Selected Photo"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
