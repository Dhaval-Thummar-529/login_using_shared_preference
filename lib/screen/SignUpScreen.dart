import 'dart:async';

import 'package:flutter/material.dart';
import 'package:login_using_shared_preference/utils/customButton.dart';
import 'package:login_using_shared_preference/utils/customInputField.dart';
import 'package:login_using_shared_preference/utils/customSnackbar.dart';
import 'package:login_using_shared_preference/utils/validations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _signUpScreen createState() => _signUpScreen();
}

class _signUpScreen extends State<SignUpScreen> {
  bool isLoading = false;

  final nameControl = TextEditingController();
  FocusNode nameNode = FocusNode();

  final cNumberControl = TextEditingController();
  FocusNode cNumberNode = FocusNode();

  final emailControl = TextEditingController();
  FocusNode emailNode = FocusNode();

  final passwordControl = TextEditingController();
  FocusNode passwordNode = FocusNode();

  final cPasswordControl = TextEditingController();
  FocusNode cPasswordNode = FocusNode();

  @override
  void dispose() {
    nameControl.dispose();
    nameNode.dispose();

    emailControl.dispose();
    emailNode.dispose();

    cNumberControl.dispose();
    cNumberNode.dispose();

    passwordControl.dispose();
    passwordNode.dispose();

    cPasswordControl.dispose();
    cPasswordNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sign Up",
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blue.withOpacity(0.5),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 20, bottom: 12),
                          child: const Text(
                            "Sign In",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        customInputField().customEdtField(
                            "Name",
                            nameControl,
                            nameNode,
                            TextInputType.name,
                            TextInputAction.next,
                            false,
                            const Icon(Icons.person),
                            true),
                        const SizedBox(
                          height: 20,
                        ),
                        customInputField().customEdtField(
                            "Contact No.",
                            cNumberControl,
                            cNumberNode,
                            TextInputType.phone,
                            TextInputAction.next,
                            false,
                            const Icon(Icons.phone),
                            true),
                        const SizedBox(
                          height: 20,
                        ),
                        customInputField().customEdtField(
                            "Email",
                            emailControl,
                            emailNode,
                            TextInputType.emailAddress,
                            TextInputAction.next,
                            false,
                            const Icon(Icons.email),
                            true),
                        const SizedBox(
                          height: 20,
                        ),
                        customInputField().customEdtField(
                            "Password",
                            passwordControl,
                            passwordNode,
                            TextInputType.visiblePassword,
                            TextInputAction.next,
                            true,
                            const Icon(Icons.lock),
                            true),
                        const SizedBox(
                          height: 20,
                        ),
                        customInputField().customEdtField(
                            "Confirm Password",
                            cPasswordControl,
                            cPasswordNode,
                            TextInputType.visiblePassword,
                            TextInputAction.done,
                            true,
                            const Icon(Icons.lock),
                            true),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isLoading
                          ? CircularProgressIndicator(
                              color: Colors.blue.withOpacity(0.5),
                              strokeWidth: 5.0,
                            )
                          : customButton().customBtn("Sign Up", () {
                              signUp(context);
                            }),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              )
            ],
          ),
        ),
      ),
    );
  }

  void signUp(BuildContext context) {
    var name = nameControl.value.text;
    var email = emailControl.value.text;
    var phone = cNumberControl.value.text;
    var password = passwordControl.value.text;
    var cPassword = cPasswordControl.value.text;

    if (name.isEmpty) {
      customSnackbar().showSnackbar(
        label: "Please enter name!",
        context: context,
      );
      nameNode.requestFocus();
    } else if (!validations().nameValidator(name)) {
      customSnackbar()
          .showSnackbar(label: "Please enter a valid name!", context: context);
      nameNode.requestFocus();
    } else if (phone.isEmpty) {
      customSnackbar().showSnackbar(
          label: "Please enter contact number!", context: context);
      cNumberNode.requestFocus();
    } else if (!validations().phoneValidator(phone)) {
      customSnackbar().showSnackbar(
          label: "Please enter a valid contact number!", context: context);
      cNumberNode.requestFocus();
    } else if (email.isEmpty) {
      customSnackbar()
          .showSnackbar(label: "Please enter email!", context: context);
      emailNode.requestFocus();
    } else if (!validations().emailValidator(email)) {
      customSnackbar()
          .showSnackbar(label: "Please enter a valid email!", context: context);
      emailNode.requestFocus();
    } else if (password.isEmpty) {
      customSnackbar()
          .showSnackbar(label: "Please enter password!", context: context);
      passwordNode.requestFocus();
    } else if (!validations().passwordValidator(password)) {
      customSnackbar().showSnackbar(
          label:
              "Please enter a valid password with at-least one digit, one Upper character and one special character",
          context: context);
      passwordNode.requestFocus();
    } else if (cPassword.isEmpty) {
      customSnackbar().showSnackbar(
          label: "Please enter compare password", context: context);
      cPasswordNode.requestFocus();
    } else if (!(password == cPassword)) {
      customSnackbar()
          .showSnackbar(label: "Password does not match!", context: context);
      cPasswordNode.requestFocus();
    } else {
      storeData(name, email, phone, password, context);
    }
  }

  void storeData(String name, String email, String phone, String password,
      BuildContext context) async {
    List<String> data = [name, phone, email, password];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(email)) {
      customSnackbar()
          .showSnackbar(label: "Email Already exists!", context: context);
    } else {
      if (isLoading) return;
      setState(() {
        isLoading = true;
      });
      prefs.setStringList(email, data);
      Timer(
          const Duration(seconds: 3),
          () => {
                setState(() {
                  isLoading = true;
                }),
                customSnackbar().showSnackbar(
                    label: "Please login with shared credentials",
                    context: context),
                Navigator.pop(context)
              });
    }
  }
}
