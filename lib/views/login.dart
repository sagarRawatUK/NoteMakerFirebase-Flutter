import 'package:NoteAppFirebase/constants/widgets.dart';
import 'package:NoteAppFirebase/helper/auth.dart';
import 'package:NoteAppFirebase/views/taskScreen.dart';
import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  final Function toggle;
  LogIn(this.toggle);
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  AuthMethods authMethods = AuthMethods();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();

  signMeIn() {
    authMethods
        .signInWithEmailAndPassword(
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Login",
                  style: TextStyle(color: Colors.white, fontSize: 50),
                ),
                SizedBox(
                  height: 30,
                ),
                Column(
                  children: [
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
                            controller: emailTextEditingController,
                            decoration: textFieldDecoration("Email"),
                            style: whiteTextStyle(),
                          ),
                          TextFormField(
                              validator: (value) {
                                return value.isEmpty || value.length < 6
                                    ? "Please enter a valid Password"
                                    : null;
                              },
                              obscureText: true,
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
                        signMeIn();
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
                          "Log in",
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
                          "Don't have an account? ",
                          style: mediumWhiteTextStyle(),
                        ),
                        GestureDetector(
                          onTap: () => widget.toggle(),
                          child: Text(
                            "Register now",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
