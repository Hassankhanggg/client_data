// import 'dart:ffi';

import 'package:client_data/screens/users/UserScreen.dart';
import 'package:client_data/utils/user%20utils/PostUser.dart';
import 'package:client_data/authentication/authentication_service.dart';
import 'package:client_data/utils/default/default.dart';
import 'package:client_data/utils/user%20utils/model%20user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/src/provider.dart';

class signup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultWidget(_signup(), true, false, true),
    );
  }
}

class _signup extends StatelessWidget {
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController name = TextEditingController();
    TextEditingController password = TextEditingController();
    Future<String> create_auth() async {
      return await context.read<AuthenticationService>().signUp(
            email: email.text.trim(),
            password: password.text.trim(),
          );
    }

    return Column(
      children: [
        TextField(
          controller: name,
          decoration: InputDecoration(
            hintText: 'Name',
            hintStyle: TextStyle(color: Colors.white),
            filled: true,
            fillColor: Colors.blueGrey.shade500,
            labelStyle: const TextStyle(fontSize: 12),
            contentPadding: const EdgeInsets.only(left: 30),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey.shade500),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey.shade500),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        TextField(
          controller: email,
          decoration: InputDecoration(
            hintText: 'Enter email or Phone number',
            hintStyle: TextStyle(color: Colors.white),
            filled: true,
            fillColor: Colors.blueGrey.shade500,
            labelStyle: const TextStyle(fontSize: 12),
            contentPadding: const EdgeInsets.only(left: 30),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey.shade500),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey.shade500),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        SizedBox(height: 30),
        TextField(
          controller: password,
          decoration: InputDecoration(
            hintText: 'Enter new Password',
            hintStyle: TextStyle(color: Colors.white),
            counterStyle: TextStyle(color: Colors.white),
            suffixIcon: const Icon(
              Icons.visibility_off_outlined,
              color: Colors.grey,
            ),
            filled: true,
            fillColor: Colors.blueGrey.shade500,
            labelStyle: const TextStyle(fontSize: 12),
            contentPadding: const EdgeInsets.only(left: 30),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey.shade500),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey.shade500),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
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
              create_auth().then((value) async {
                print(value);
                if (value == "Signed up") {
                  FirebaseAuth _auth = FirebaseAuth.instance;
                  var x = DonaloPostUser(
                      Name: name.text,
                      // offeredRate: int.parse(offer.text),
                      // ports: double.parse(ports.text),
                      userID: _auth.currentUser.uid,
                      email: email.text);
                  await PostDataUser().post(x).then((value) {
                    print('$value');
                    Navigator.push((context),
                        MaterialPageRoute(builder: (context) => UserScreen()));
                  });
                }
              });

              Navigator.push(
                  (context),
                  MaterialPageRoute(
                      builder: (context) => UserScreen(
                          // name: name.text,
                          // email: email.text,
                          )));
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
    );
  }
}
