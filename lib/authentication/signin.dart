// import 'dart:js';

import 'package:client_data/screens/users/UserScreen.dart';
import 'package:client_data/authentication/authentication_service.dart';
import 'package:client_data/authentication/signup.dart';
import 'package:client_data/utils/customs/appTextForm.dart';
import 'package:client_data/utils/customs/customButton.dart';
import 'package:client_data/utils/default/default.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class signin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultWidget(_formLogin(), true, false, false),
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
  bool isVisible = false;
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

  TextEditingController password = TextEditingController();

  Widget build(BuildContext context) {
    void func2() {
      Navigator.push(
          (context), MaterialPageRoute(builder: (context) => Signup()));
    }

    return Form(
      key: _formKey,
      child: Column(
        children: [
          AppTextForm(
            onFieldSubmit: (value){ 
              fieldSubmit(value);
            },
              validator: (value) {
                if (value == null || value.isEmpty)
                  return "This field is Required";
                else if(!isEmail(email.text))
                  return "Provide a valid Email address";
                else
                return status;
              },
              cont: email,
              s: "Enter email or phone number",
              obscure: false),
          SizedBox(height: 10),
          AppTextForm(
            
            onFieldSubmit: (value){ 
              fieldSubmit(value);
            },
              validator: (value) {
                if (value == null || value.isEmpty)
                  return "This is Required Field";
                else
                return status;
              },
              cont: password,
              s: "Password",
              obscure: !isVisible,
            visibleIcon: IconButton(
              icon: Icon(isVisible ? Icons.visibility: Icons.visibility_off),
              color: Colors.white,
              onPressed: (){
                setState(() {
                  isVisible = !isVisible;
                });
              },
            )),
          SizedBox(height: 10),
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
                if (!_formKey.currentState.validate()) {
                  status = null;                  
                  return;
                } else {
                  inProgress = true;
                  context
                      .read<AuthenticationService>()
                      .signIn(
                        email: email.text.trim(),
                        password: password.text.trim(),
                      )
                      .then((value) async {
                   if (value == "Signed in")
                      Navigator.push(
                          (context),
                          MaterialPageRoute(
                              builder: (context) => UserScreen()));
                    else {
                      setState(() {
                        inProgress = false;
                        status = 'Email or Password is not valid';
                      });
                    }
                  });
                }
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
          CustomButton(
              Text(
                "Register a new account",
                style: TextStyle(color: Colors.white),
              ),
              func2),
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
  void fieldSubmit(value){
    
                if (!_formKey.currentState.validate()) {
                  status = null;                  
                  return;
                } else {
                  inProgress = true;
                  context
                      .read<AuthenticationService>()
                      .signIn(
                        email: email.text.trim(),
                        password: password.text.trim(),
                      )
                      .then((value) async {
                   if (value == "Signed in")
                      Navigator.push(
                          (context),
                          MaterialPageRoute(
                              builder: (context) => UserScreen()));
                    else {
                      setState(() {
                        inProgress = false;
                        status = 'Email or Password is not valid';
                      });
                    }
                  });
                }
  }
}
