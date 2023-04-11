import 'package:flutter/material.dart';
import 'package:login_using_shared_preference/screen/HomeScreen.dart';
import 'package:login_using_shared_preference/screen/SignUpScreen.dart';
import 'package:login_using_shared_preference/utils/customSnackbar.dart';
import 'package:login_using_shared_preference/utils/customButton.dart';
import 'package:login_using_shared_preference/utils/customInputField.dart';
import 'package:login_using_shared_preference/utils/validations.dart';

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign In"),
        centerTitle: true,
      ),
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
                              false),
                          const SizedBox(
                            height: 20,
                          ),
                          customInputField().customEdtField(
                              "Password",
                              passwordControl,
                              passwordNode,
                              TextInputType.visiblePassword,
                              TextInputAction.done,
                              true),
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
                    customButton().customBtn("Sign In", () {
                      login(context);
                    }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        TextButton(
                          onPressed: () {
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
      FocusManager.instance.primaryFocus!.unfocus();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    }
  }
}
