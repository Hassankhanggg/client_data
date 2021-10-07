// import 'dart:ffi';

import 'package:client_data/screens/UserScreen.dart';
import 'package:client_data/utils/PostUser.dart';
import 'package:client_data/utils/authentication_service.dart';
import 'package:client_data/main.dart';
import 'package:client_data/utils/default.dart';
import 'package:client_data/utils/model%20user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    void create_auth() {
      context.read<AuthenticationService>().signUp(
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
              create_auth();
              Navigator.push((context),
                  MaterialPageRoute(builder: (context) => UserScreen()));

              // FirebaseAuth _auth = FirebaseAuth.instance;
              // var x = DonaloPostUser(
              //   Name: name.text,
              //   email: email.text,
              //   userID: _auth.currentUser.uid,
              // );
              // await PostDataUser().post(x).then((value) {
              //   print('$value');
              // });

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
