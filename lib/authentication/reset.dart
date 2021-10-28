import 'package:client_data/authentication/signin.dart';
import 'package:client_data/screens/users/UserScreen.dart';
import 'package:client_data/authentication/authentication_service.dart';
import 'package:client_data/utils/customs/appTextForm.dart';
import 'package:client_data/utils/default/default.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/src/provider.dart';

class Reset extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultWidget(ResetClass(), true, false, false, false),
    );
  }
}

class ResetClass extends StatefulWidget {
  @override
  State<ResetClass> createState() => _ResetClassState();
}

class _ResetClassState extends State<ResetClass> with TickerProviderStateMixin {
  AnimationController controller;
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool inProgress = false;
  bool isVisible = false;
  bool error = false;
  String status;
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          AppTextForm(
              onFieldSubmit: (value) {
                // fieldSubmit(value);
              },
              validator: (value) {
                if (value == null || value.isEmpty)
                  return "This field is Required";
                else if (!isEmail(email.text))
                  return "Provide a valid Email address";
                // else
                //   return status;
              },
              cont: email,
              s: "Enter email ",
              obscure: false),
          SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              children: [
                ElevatedButton(
                  child: SizedBox(
                      width: 250,
                      height: 50,
                      child: Center(
                          child: inProgress
                              ? CircularProgressIndicator(
                                  value: controller.value * 2,
                                  semanticsLabel: 'Linear progress indicator',
                                )
                              : Text(
                                  "Reset password",
                                  style: TextStyle(color: Colors.white),
                                ))),
                  onPressed: () async {
                    inProgress = true;
                    if (!_formKey.currentState.validate()) {
                      status = null;
                      return;
                    } else {
                      if (email.text == "fahad@familycommunication.it") {
                        Fluttertoast.showToast(
                            msg: "Admin can't reset password here",
                            timeInSecForIosWeb: 4,
                            backgroundColor: Colors.white54);
                      } else {
                        try {
                          await _auth.sendPasswordResetEmail(email: email.text);
                        } on FirebaseAuthException catch (e) {
                          print("[[" + e.message + "]]");
                          //return e.message;

                          Fluttertoast.showToast(
                              msg: e.message,
                              timeInSecForIosWeb: 4,
                              backgroundColor: Colors.white54);
                          error = true;
                          // throw FirebaseAuthException;
                        }
                        if (error) {
                          Fluttertoast.showToast(
                              msg: "Email has been sent to $email",
                              timeInSecForIosWeb: 4,
                              backgroundColor: Colors.white54);
                        }
                      }
                    }
                    inProgress = false;
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.cyan,
                    onPrimary: Colors.cyan[50],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  child: SizedBox(
                      width: 250,
                      height: 50,
                      child: Center(
                          child: inProgress
                              ? CircularProgressIndicator(
                                  value: controller.value * 2,
                                  semanticsLabel: 'Linear progress indicator',
                                )
                              : Text(
                                  "Back to Sign in ",
                                  style: TextStyle(color: Colors.white),
                                ))),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Signin()));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.cyan,
                    onPrimary: Colors.cyan[50],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool isEmail(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return regex.hasMatch(email);
  }

  // void fieldSubmit(value) {
  //   if (!_formKey.currentState.validate()) {
  //     status = null;
  //     return;
  //   } else {
  //     inProgress = true;
  //     context
  //         .read<AuthenticationService>()
  //         .signIn(
  //           email: email.text.trim(),
  //           password: password.text.trim(),
  //         )
  //         .then((value) async {
  //       if (value == "Signed in")
  //         Navigator.push(
  //             (context), MaterialPageRoute(builder: (context) => UserScreen()));
  //       else {
  //         setState(() {
  //           inProgress = false;
  //           status = 'Email or Password is not valid';
  //         });
  //       }
  //     });
  //   }
  // }
}
