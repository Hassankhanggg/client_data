import 'package:client_data/screens/UserScreen.dart';
import 'package:client_data/screens/client.dart';
import 'package:client_data/screens/select.dart';
import 'package:client_data/utils/PostUser.dart';
import 'package:client_data/utils/model%20user.dart';
import 'package:client_data/utils/post.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ItemCardUser extends StatefulWidget {
  final DonaloPostUser Userproduct;
   ItemCardUser({
    Key key,
    this.Userproduct,
    DonaloPostUser donaloPostUser,
  }) : super(key: key);

  @override
  State<ItemCardUser> createState() => _ItemCardUserState();
}

class _ItemCardUserState extends State<ItemCardUser> {
  String userID = DonaloPostUser().userID;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            (context),
            MaterialPageRoute(
                builder: (context) => SelectScreen(
                      userID: userID,
                    )));
      },
      // onTap: press,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        // mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              // height: 180,
              // width: 160,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/client.jpg",
                    width: 50,
                    height: 40,
                    //fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text("${widget.Userproduct.Name}"),
                  SizedBox(height: 5),
                  // SizedBox(height: 5),
                  Text(widget.Userproduct.email),
                  SizedBox(height: 5),
                  // Text("Rate: ${widget.Userproduct.offeredRate.toString()}"),
                  // Spacer(),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.delete_forever),
                    color: Colors.white,
                    highlightColor: Colors.red,
                    hoverColor: Colors.green,
                    focusColor: Colors.purple,
                    splashColor: Colors.yellow,
                    disabledColor: Colors.amber,
                    iconSize: 20,
                    onPressed: () {
                      setState(() {
                        PostDataUser().deletePost(widget.Userproduct);
                        Navigator.push(
                            (context),
                            MaterialPageRoute(
                                builder: (context) => UserScreen()));
                        print("delete User");
                      });
                    },
                  ),
                ],
              ), //     child: Hero(tag: "${Userproduct.id}",   )
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 5),
          //   child: Text(
          //     // Userproducts is out demo list
          //     Userproduct.name,
          //   ),
          // ),
          // Text(
          //   "${Userproduct.postID}",
          //   style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          // )
        ],
      ),
    );
  }
}
