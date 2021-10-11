import 'package:client_data/screens/users/add%20user.dart';
import 'package:client_data/utils/user%20utils/PostUser.dart';
import 'package:client_data/utils/card.dart';
import 'package:client_data/utils/customs/customButton.dart';
import 'package:client_data/utils/default/default.dart';
import 'package:client_data/utils/user%20utils/itemCardUsers.dart';
import 'package:client_data/utils/user%20utils/model%20user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  UserScreen();
  // final String name, email;

  @override
  Widget build(BuildContext context) {
    // if (name != null) ("name is : " + name);
    // if (email != null) ("email is : " + email);
    return Scaffold(
      // key: _scaffold,
      body: DefaultWidget(UserScreenClass(), false, true, true,true),
    );
  }
}

BuildContext globalContext;

class UserScreenClass extends StatefulWidget {
  @override
  State<UserScreenClass> createState() => _UserScreenClassState();
}

class _UserScreenClassState extends State<UserScreenClass> {
  void funcRefresh() async {
    // print("object");
    FirebaseAuth _auth = FirebaseAuth.instance;
    var x = DonaloPostUser(
        Name: name.text,
        // offeredRate: int.parse(offer.text),
        // ports: double.parse(ports.text),
        userID: _auth.currentUser.uid,
        email: email.text);
    await PostDataUser().post(x).then((value) {
      // print('$value');
      Navigator.push(
          (context), MaterialPageRoute(builder: (context) => UserScreen()));
      // inProgress = false;
    });
  }

  // void initState() {
  //   super.initState();
  //   // WidgetsBinding.instance.addPostFrameCallback((_) =>
  //   funcRefresh(); //)-
  // }

  @override
  Widget build(BuildContext context) {
    // @override
    // Future<void> initState() async {
    //   FirebaseAuth _auth = FirebaseAuth.instance;
    //   var x = DonaloPostUser(
    //       Name: name.text,
    //       // offeredRate: int.parse(offer.text),
    //       // ports: double.parse(ports.text),
    //       userID: _auth.currentUser.uid,
    //       email: email.text);
    //   await PostDataUser().post(x).then((value) {
    //     print('$value');
    //     Navigator.push(
    //         (context), MaterialPageRoute(builder: (context) => UserScreen()));
    //     // inProgress = false;
    //   });
    // }

    // Stream<List<DonaloPost>> l;
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        // customButton("Add new customer", func),
 
        // ElevatedButton(
        //   child: const SizedBox(
        //       width: 190,
        //       height: 50,
        //       child: Center(
        //           child: Text(
        //         "refresh",
        //         style: TextStyle(color: Colors.white),
        //       ))),
        //   onPressed: () async {

        //     // l = PostDataUser().getPosts() as Stream<List<DonaloPostUser>>;
        //     // print(l);
        //     // var x = DonaloPostUser(
        //     //   Name: name.text,
        //     //   email: email.text,
        //     //   userID: _auth.currentUser.uid,
        //     // );
        //     // await PostDataUser().post(x).then((value) {
        //     //   print('$value');
        //     // });
        //     // Navigator.push((context),
        //     //     MaterialPageRoute(builder: (context) => UserScreen()));
        //   },
        //   style: ElevatedButton.styleFrom(
        //     primary: Colors.purple.shade900,
        //     onPrimary: Colors.redAccent,
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(15),
        //     ),
        //   ),
        // ),
        
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: cards.length * 110.0,
                child: StreamBuilder(
                  stream: PostDataUser().getPosts(
                      ),
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
                            childAspectRatio: //big                 //small
                                width > 700
                                    ? width / 1000 * 0.5
                                    : width / 1000 * 1.5,
                          ),
                          itemBuilder: (context, index) => ItemCardUser(
                            // widget.c,

                                Userproduct: data[index],
                              ));
                    } else {
                      return Center(
                        child: Text('Error'),
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

  void func() {
    Navigator.push(
        (globalContext), MaterialPageRoute(builder: (context) => addUser()));
  }
}
