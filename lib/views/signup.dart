import 'package:NoteAppFirebase/constants/widgets.dart';
import 'package:NoteAppFirebase/helper/auth.dart';
import 'package:NoteAppFirebase/views/taskScreen.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  final Function toggle;
  SignUp(this.toggle);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  AuthMethods authMethods = AuthMethods();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  TextEditingController userNameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  signMeUp() {
    authMethods
        .signUpWithEmailAndPassword(
            emailTextEditingController.text, passwordTextEditingController.text)
        .then((user) => {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => TaskScreen(user.uid)))
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Sign Up",
                    style: TextStyle(color: Colors.white, fontSize: 50)),
                SizedBox(
                  height: 50,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          return value.isEmpty || value.length < 4
                              ? "Please enter a valid Username"
                              : null;
                        },
                        controller: userNameTextEditingController,
                        decoration: textFieldDecoration("Name"),
                        style: whiteTextStyle(),
                      ),
                      TextFormField(
                          validator: (value) {
                            return RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$")
                                    .hasMatch(value)
                                ? null
                                : "Please enter a valid Email";
                          },
                          controller: emailTextEditingController,
                          decoration: textFieldDecoration("Email"),
                          style: whiteTextStyle()),
                      TextFormField(
                          obscureText: true,
                          validator: (value) {
                            return value.isEmpty || value.length < 6
                                ? "Please enter a valid Password"
                                : null;
                          },
                          controller: passwordTextEditingController,
                          decoration: textFieldDecoration("Password"),
                          style: whiteTextStyle()),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                GestureDetector(
                  onTap: () {
                    signMeUp();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: mediumWhiteTextStyle(),
                    ),
                    GestureDetector(
                      onTap: () => widget.toggle(),
                      child: Text(
                        "Login now",
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 17,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
