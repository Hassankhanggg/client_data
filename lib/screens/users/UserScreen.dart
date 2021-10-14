import 'dart:html';

import 'package:client_data/authentication/signup.dart';
import 'package:client_data/utils/customs/customButton.dart';
import 'package:client_data/utils/user%20utils/PostUser.dart';
import 'package:client_data/utils/card.dart';
import 'package:client_data/utils/default/default.dart';
import 'package:client_data/utils/user%20utils/itemCardUsers.dart';
import 'package:client_data/utils/user%20utils/model%20user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  UserScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultWidget(UserScreenClass(), false, true, true, true),
    );
  }
}

BuildContext globalContext;

class UserScreenClass extends StatefulWidget {
  @override
  State<UserScreenClass> createState() => _UserScreenClassState();
}

class _UserScreenClassState extends State<UserScreenClass> {
  bool admin = false;
  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser.email == "khan@gmail.com") {
      admin = true;
    } else {
      admin = false;
    }
    void func2() {
      Navigator.push(
          (context), MaterialPageRoute(builder: (context) => Signup()));
    }

    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        admin
            ? CustomButton(
                Text(
                  "Register a new account",
                  style: TextStyle(color: Colors.white),
                ),
                func2)
            : Text(''),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: cards.length * 110.0,
                child: StreamBuilder(
                  stream: PostDataUser().getPosts(),
                  builder:
                      (context, AsyncSnapshot<List<DonaloPostUser>> snapshot) {
                    if (snapshot.hasData) {
                      var data = snapshot.data;
                      return GridView.builder(
                          itemCount: data.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: width > 1000
                                      ? 4
                                      : width > 800
                                          ? 3
                                          : width > 600
                                              ? 2
                                              : 2,
                                  mainAxisSpacing: 20,
                                  crossAxisSpacing: 20,
                                  childAspectRatio: width > 800
                                      ? width / 1000 * 0.6
                                      : width > 1000
                                          ? width / 1000 * 0.6
                                          : width / 1000 * 2.8
                                  // // : width > 700
                                  //         ? width / 1000 * 12
                                  //         : width > 600
                                  //             ? width / 1000 * 12
                                  //             : width > 500
                                  //                 ? width / 1000 * 12
                                  //                 : width / 1000 * 12,
                                  ),
                          itemBuilder: (context, index) => ItemCardUser(
                                Userproduct: data[index],
                              ));
                    } else {
                      return Center(
                        child: Text('Loading....'),
                      );
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
