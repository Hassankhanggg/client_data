import 'package:client_data/authentication/signup.dart';
import 'package:client_data/utils/customs/customButton.dart';
import 'package:client_data/utils/default/Navbar.dart';
import 'package:client_data/utils/user%20utils/PostUser.dart';
import 'package:client_data/utils/card.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:client_data/utils/user%20utils/itemCardUsers.dart';
import 'package:client_data/utils/user%20utils/model%20user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  UserScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          UserScreenClass(), //DefaultWidget(UserScreenClass(), false, true, true, true),
      // appBar: Navbar(showlogout: true , showBackicon: false, showHome: true),
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
    if (FirebaseAuth.instance.currentUser.email ==
        "fahad@familycommunication.it") {
      admin = true;
    } else {
      admin = false;
    }
    void func2() {
      Navigator.push(
          (context), MaterialPageRoute(builder: (context) => Signup()));
    }

    double width = MediaQuery.of(context).size.width;
    double length = MediaQuery.of(context).size.height;
    int aa = width.round(); // / 3;
    print("${cards.length}" + "$length");
    return SingleChildScrollView(
      child: Column(
        children: [
          Navbar(true, false, true),
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width / 4),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: length,
                    child: StreamBuilder(
                      stream: PostDataUser().getPosts(),
                      builder: (context,
                          AsyncSnapshot<List<DonaloPostUser>> snapshot) {
                        if (snapshot.hasData) {
                          var data = snapshot.data;
                          return GridView.builder(
                              itemCount: data.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      // width > 1000
                                      //     ? 4
                                      //     : width > 800
                                      //         ? 3
                                      //         : width > 600
                                      //             ? 2
                                      //             : 1,
                                      mainAxisSpacing: 20,
                                      crossAxisSpacing: 20,
                                      childAspectRatio: width / 1000 * 0.1
                                      // width < 500
                                      //     ? (width / 1000) * 3
                                      //     : width < 800
                                      //         ? (width / 1000) * 1.3
                                      //         : (width / 1000) * 0.6
                                      // width > 100
                                      //     ? width / 1000 * 1
                                      //     : width > 800
                                      //         ? width / 1000 * 0.6
                                      //         : width > 1000
                                      //             ? width / 1000 * 0.6
                                      //             : width / 1000 * 2.8
                                      // width > 700
                                      //     ? width / 1000 * 12
                                      //     : width > 600
                                      //         ? width / 1000 * 12
                                      //         : width > 500
                                      //             ? width / 1000 * 12
                                      //             : width / 1000 * 12,
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
          ),
        ],
      ),
    );
  }
}
