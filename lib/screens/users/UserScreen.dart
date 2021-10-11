import 'package:client_data/screens/users/add%20user.dart';
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
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Row(
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
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: width > 1000
                              ? 4
                              : width > 800
                                  ? 3
                                  : width > 600
                                      ? 2
                                      : 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          childAspectRatio: width > 700
                              ? width / 1000 * 0.5
                              : width / 1000 * 1.5,
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
    );
  }
}
