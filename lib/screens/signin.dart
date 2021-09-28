// import 'dart:js';

import 'package:client_data/authentication_service.dart';
import 'package:client_data/screens/select.dart';
import 'package:client_data/screens/signup.dart';
import 'package:client_data/utils/appTextForm.dart';
import 'package:client_data/utils/customButton.dart';
import 'package:client_data/utils/default.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class signin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: missing_required_param
      body: defaultWidget(_formLogin(), true, false, false),
    );
  }
}

class _formLogin extends StatefulWidget {
  @override
  State<_formLogin> createState() => _formLoginState();
}

class _formLoginState extends State<_formLogin> with TickerProviderStateMixin {
  AnimationController controller;
  bool inProgress = false;
  String status = 'Reqiured';
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

  TextEditingController password = TextEditingController();

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    void func2() {
      Navigator.push(
          (context), MaterialPageRoute(builder: (context) => signup()));
    }

    void func() {
      context
          .read<AuthenticationService>()
          .signIn(
            email: email.text.trim(),
            password: password.text.trim(),
          )
          .then((value) => print(value));
    }

    // openLoadingDialog(BuildContext context, String text) {
    //   showDialog(
    //       context: context,
    //       barrierDismissible: false,
    //       builder: (context) => AlertDialog(
    //             content: Row(children: <Widget>[
    //               SizedBox(
    //                   width: 30,
    //                   height: 30,
    //                   child: CircularProgressIndicator(
    //                       strokeWidth: 1,
    //                       valueColor: AlwaysStoppedAnimation(Colors.black))),
    //               SizedBox(width: 10),
    //               Text(text)
    //             ]),
    //           ));
    // }

    // r = context;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          appTextForm(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return status;
                } else
                  return status;
              },
              cont: email,
              s: "Enter email or Phone number",
              obscure: false),
          SizedBox(height: 10),
          appTextForm(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return status;
                } else
                  return status;
              },
              cont: password,
              s: "Password",
              obscure: true),
          SizedBox(height: 10),
          // customButton("Sign in", func),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: ElevatedButton(
              child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Center(
                      child: inProgress
                          ? CircularProgressIndicator(
                              value: controller.value * 2,
                              semanticsLabel: 'Linear progress indicator',
                            )
                          : Text(
                              "Sign In",
                              style: TextStyle(color: Colors.white),
                            ))),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  // _formKey.currentState.save();

                  print("if");
                } else {
                  print("else");

                  // _formKey.currentState.save();
                  inProgress = true;
                  context
                      .read<AuthenticationService>()
                      .signIn(
                        email: email.text.trim(),
                        password: password.text.trim(),
                      )
                      .then((value) {
                    if (value == "Signed in")
                      Navigator.push(
                          (context),
                          MaterialPageRoute(
                              builder: (context) => selectscreen()));
                    else {
                      setState(() {
                        status = 'Invalid Email or Password';
                      });
                    }
                  });
                }

                // Navigator.push((context),
                //     MaterialPageRoute(builder: (context) => selectscreen()));
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple,
                onPrimary: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          customButton(
              Text(
                "Register a new account",
                style: TextStyle(color: Colors.white),
              ),
              func2),
          // ElevatedButton(
          //   child:   SizedBox(
          //       width: 190,
          //       height: 50,
          //       child: Center(
          //           child: Text(
          //         "Register a new account",
          //         style: TextStyle(color: Colors.white),
          //       ))),
          //   onPressed: () => Navigator.push(
          //       (context), MaterialPageRoute(builder: (context) => signup())),
          //   style: ElevatedButton.styleFrom(
          //     primary: Colors.deepPurple,
          //     onPrimary: Colors.redAccent,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(15),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
