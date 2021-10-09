import 'package:client_data/screens/users/UserScreen.dart';
import 'package:client_data/utils/customs/appTextForm.dart';
import 'package:client_data/utils/user%20utils/PostUser.dart';
import 'package:client_data/authentication/authentication_service.dart';
import 'package:client_data/utils/default/default.dart';
import 'package:client_data/utils/user%20utils/model%20user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class signup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultWidget(_signup(), true, false, true),
    );
  }
}

class _signup extends StatefulWidget {
  
  
  @override
  __signupState createState() => __signupState();
}

class __signupState extends State<_signup>{
    
    final _formkey = GlobalKey<FormState>();
    TextEditingController email = TextEditingController();
    
    TextEditingController name = TextEditingController();
    TextEditingController password = TextEditingController();
    String status;
    Future<String> create_auth() async {
      return await context.read<AuthenticationService>().signUp(
            email: email.text.trim(),
            password: password.text.trim(),
          );
    }

  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        children: [
          AppTextForm(
            cont: name,
            s: "Name",
            obscure: false,
            validator: (value){
              if(value == null || value.isEmpty)
              return "This is required field";
              else return status;
            },
          )
          ,
          SizedBox(
            height: 30,
          ),
         AppTextForm(
           cont: email,
           s: "Enter your Email or Phone Number",
           validator: (value){
             if (value == null || value.isEmpty)
             return "This is Required Field";
             else if (!isEmail(email.text))
             return "Enter a valid Email Address";
             else
             return status;
           },
         ),
          SizedBox(height: 30),
          AppTextForm(
            cont: password,
            s: "Enter your Password",
            obscure: true,
            validator: (value){
              if(value == null || value.isEmpty)
              return "This is Required Field";
              else if(value.length < 6)
              return "Password must be at least 6 characters";
              else
              return status;
            },        
          )
         ,
          const SizedBox(height: 40),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: ElevatedButton(
              child: const SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Center(
                      child: Text(
                    "Sign UP",
                    style: TextStyle(color: Colors.white),
                  ))),
              onPressed: () async {
                if(!_formkey.currentState.validate()){
                    status = null;
                    return;
                  }
                else{
                  create_auth().then((value) async {
                  
                  if (value == "Signed up") {
                    FirebaseAuth _auth = FirebaseAuth.instance;
                    var x = DonaloPostUser(
                        Name: name.text,
                        // offeredRate: int.parse(offer.text),
                        // ports: double.parse(ports.text),
                        userID: _auth.currentUser.uid,
                        email: email.text);
                    await PostDataUser().post(x).then((value) {
                      Navigator.push((context),
                          MaterialPageRoute(builder: (context) => UserScreen()));
                    });
                  }                 
                });
                };
    
                // Navigator.push(
                //     (context),
                //     MaterialPageRoute(
                //         builder: (context) => UserScreen(
                //             // name: name.text,
                //             // email: email.text,
                //             )));
                // inProgress = true;
                // final firebaseUser = context.watch<User>();
    
                // if (firebaseUser != null) {}
    
                // FirebaseAuth _auth = FirebaseAuth.instance;
    
                // Navigator.push(
                //     (context), MaterialPageRoute(builder: (context) => MyApp()));
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
        ],
      ),
    );
  }

  bool isEmail(String email) {
    Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return regex.hasMatch(email);
  }
}
