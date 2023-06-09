import 'dart:async';

import 'package:flutter/material.dart';
import 'package:login_using_shared_preference/screen/HomeScreen.dart';
import 'package:login_using_shared_preference/screen/SignUpScreen.dart';
import 'package:login_using_shared_preference/utils/customSnackbar.dart';
import 'package:login_using_shared_preference/utils/customButton.dart';
import 'package:login_using_shared_preference/utils/customInputField.dart';
import 'package:login_using_shared_preference/utils/validations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  customButton cb = customButton();
  customSnackbar csnackbar = customSnackbar();

  //Email Controller and FocusNode
  final emailControl = TextEditingController();
  FocusNode emailNode = FocusNode();

  //Password Controller and FocusNode
  final passwordControl = TextEditingController();
  FocusNode passwordNode = FocusNode();

  final newPassControl = TextEditingController();
  FocusNode newPassNode = FocusNode();

  final newRPassControl = TextEditingController();
  FocusNode newRPassNode = FocusNode();

  final emailPassControl = TextEditingController();
  FocusNode emailPassNode = FocusNode();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    //Email Dispose
    emailControl.dispose();
    emailNode.dispose();

    //Password Dispose
    passwordControl.dispose();
    passwordNode.dispose();

    newPassControl.dispose();
    newPassNode.dispose();

    newRPassControl.dispose();
    newRPassNode.dispose();

    emailPassControl.dispose();
    emailPassNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
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
                          )
                        ],
                      ),
                      Column(
                        children: [
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
                              TextInputAction.done,
                              true,
                              const Icon(Icons.lock),
                              true),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 40),
                                child: TextButton(
                                  onPressed: () {
                                    displayDialog();
                                  },
                                  child: const Text(
                                    "Forgot password?",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    isLoading
                        ? CircularProgressIndicator(
                            color: Colors.blue.withOpacity(0.5),
                            strokeWidth: 5.0,
                          )
                        : customButton().customBtn("Sign In", () {
                            login(context);
                          }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        TextButton(
                          onPressed: () {
                            emptyAllFields();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SignUpScreen()));
                          },
                          style: const ButtonStyle(),
                          child: const Text("Sign Up"),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login(BuildContext context) {
    var email = emailControl.value.text;
    var password = passwordControl.value.text;
    if (email.isEmpty) {
      csnackbar.showSnackbar(label: "Please enter email!", context: context);
      emailNode.requestFocus();
    } else if (!validations().emailValidator(email)) {
      csnackbar.showSnackbar(
          label: "Please enter valid email!", context: context);
      emailNode.requestFocus();
    } else if (password.isEmpty) {
      csnackbar.showSnackbar(label: "Please enter password!", context: context);
      passwordNode.requestFocus();
    } else if (!validations().passwordValidator(password)) {
      csnackbar.showSnackbar(
          label:
              "Please enter a valid password with at-least one digit, one Upper character and one special character",
          context: context);
      passwordNode.requestFocus();
    } else {
      checkEmailPassword(email, password, context);
    }
  }

  void checkEmailPassword(
      String email, String password, BuildContext context) async {
    List<String> data = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(email)) {
      data = prefs.getStringList(email)!;
      if (data[3] == password) {
        prefs.setStringList("cUser", [email, "1"]);
        if (isLoading) return;
        setState(() {
          isLoading = true;
        });
        Timer(
            const Duration(seconds: 3),
            () => {
                  Navigator.pop(context),
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeScreen())),
                  setState(() {
                    isLoading = false;
                  }),
                });
      } else {
        customSnackbar()
            .showSnackbar(label: "Incorrect password!", context: context);
        passwordNode.requestFocus();
      }
    } else {
      customSnackbar()
          .showSnackbar(label: "Email does not exists!", context: context);
      emailNode.requestFocus();
    }
  }

  void emptyAllFields() {
    FocusManager.instance.primaryFocus!.unfocus();
    setState(() {
      emailControl.text = "";
      passwordControl.text = "";
    });
  }

  forgotPassword(String email, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> data = [];
    if (prefs.containsKey(email)) {
      data = prefs.getStringList(email)!;
      if (newPassControl.value.text == newRPassControl.value.text) {
        prefs.setStringList(
            email, [data[0], data[1], data[2], newPassControl.value.text]);
        Navigator.of(context).pop();
      } else {
        customSnackbar()
            .showSnackbar(label: "Password does not match", context: context);
      }
    } else {
      customSnackbar()
          .showSnackbar(label: "Email does not exist", context: context);
    }
  }

  displayDialog() async {
    return showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (context) {
          return Container(
            child: Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "Enter New Password",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                const SizedBox(
                  height: 5,
                ),
                Column(
                  children: [
                    customInputField().customEdtField(
                        "Email",
                        emailPassControl,
                        emailPassNode,
                        TextInputType.emailAddress,
                        TextInputAction.next,
                        false,
                        const Icon(Icons.email),
                        true),
                    const SizedBox(
                      height: 20,
                    ),
                    customInputField().customEdtField(
                        "New Password",
                        newPassControl,
                        newPassNode,
                        TextInputType.visiblePassword,
                        TextInputAction.next,
                        true,
                        const Icon(Icons.lock),
                        true),
                    const SizedBox(
                      height: 20,
                    ),
                    customInputField().customEdtField(
                        "Re-enter new password",
                        newRPassControl,
                        newRPassNode,
                        TextInputType.visiblePassword,
                        TextInputAction.done,
                        true,
                        const Icon(Icons.lock),
                        true),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (emailPassControl.value.text.isEmpty) {
                            customSnackbar().showSnackbar(
                                label: "Please enter email!", context: context);
                          } else if (!validations()
                              .emailValidator(emailPassControl.value.text)) {
                            customSnackbar().showSnackbar(
                                label: "Please enter valid email!");
                          } else if (newPassControl.value.text.isEmpty ||
                              newRPassControl.value.text.isEmpty) {
                            customSnackbar().showSnackbar(
                                label: "Please enter password!",
                                context: context);
                          } else if (!validations()
                              .passwordValidator(newPassControl.value.text)) {
                            customSnackbar().showSnackbar(
                                label: "Please enter valid password!");
                          } else {
                            forgotPassword(
                                emailPassControl.value.text, context);
                          }
                        },
                        child: const Text(
                          "Reset Password",
                          style: TextStyle(color: Colors.white),
                        )),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
