import 'package:flutter/material.dart';
import 'package:tiktok_clone/view/widgets/glitchEffect.dart';
import 'package:tiktok_clone/view/widgets/myTextfield.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GlithEffect(
            child: Text(
              "Tiktok",
              style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          TextInputField(
              controller: emailController,
              myIcon: Icons.email,
              myLabelText: "Email"),
          SizedBox(
            height: 20,
          ),
          TextInputField(
            controller: passwordcontroller,
            myIcon: Icons.lock,
            myLabelText: "Password",
            toHide: true,
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () {},
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: Text("Login"),
            ),
          ),
        ],
      ),
    );
  }
}
