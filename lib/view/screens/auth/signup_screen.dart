import 'package:flutter/material.dart';
import 'package:tiktok_clone/controller/auth_controller.dart';
import 'package:tiktok_clone/view/widgets/glitchEffect.dart';
import 'package:tiktok_clone/view/widgets/myTextfield.dart';

class SignUpScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController setPasswordcontroller = TextEditingController();
  TextEditingController confirmPasswordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 50),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GlithEffect(
                child: const Text(
                  "Tiktok",
                  style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              InkWell(
                onTap: () {
                  AuthController().pickImage();
                },
                child: Stack(
                  children: [
                    const CircleAvatar(
                      backgroundImage: NetworkImage(
                        "https://st3.depositphotos.com/1767687/16607/v/450/depositphotos_166074422-stock-illustration-default-avatar-profile-icon-grey.jpg",
                      ),
                      radius: 60,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextInputField(
                  controller: emailController,
                  myIcon: Icons.email,
                  myLabelText: "Email"),
              const SizedBox(
                height: 20,
              ),
              TextInputField(
                controller: setPasswordcontroller,
                myIcon: Icons.lock,
                myLabelText: "Set Password",
                toHide: true,
              ),
              const SizedBox(
                height: 20,
              ),
              TextInputField(
                controller: confirmPasswordcontroller,
                myIcon: Icons.lock,
                myLabelText: "Confirm Password",
                toHide: true,
              ),
              const SizedBox(
                height: 20,
              ),
              TextInputField(
                  controller: usernameController,
                  myIcon: Icons.person,
                  myLabelText: "Username"),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  AuthController().SignUp(
                      usernameController.text,
                      emailController.text,
                      setPasswordcontroller.text,
                      AuthController().proImg);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  child: Text("SignUp"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
