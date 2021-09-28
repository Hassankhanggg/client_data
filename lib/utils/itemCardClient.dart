import 'package:client_data/screens/client.dart';
import 'package:client_data/screens/supplier.dart';
import 'package:client_data/utils/PostClient.dart';
import 'package:client_data/utils/card.dart';
import 'package:client_data/utils/model.dart';
import 'package:client_data/utils/modelclient.dart';
import 'package:client_data/utils/post.dart';
import 'package:flutter/material.dart';

class ItemCardClient extends StatefulWidget {
  final DonaloPostClient clientproduct;
  const ItemCardClient({
    Key key,
    this.clientproduct,
    DonaloPostClient DonaloPostClient,
  }) : super(key: key);

  @override
  State<ItemCardClient> createState() => _ItemCardClientState();
}

class _ItemCardClientState extends State<ItemCardClient> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                  Text("${widget.clientproduct.cusName}"),
                  SizedBox(height: 5),
                  Text("Ports:" + widget.clientproduct.ports.toString()),
                  SizedBox(height: 5),
                  Text(widget.clientproduct.dest),
                  SizedBox(height: 5),
                  Text("Rate: ${widget.clientproduct.offeredRate.toString()}"),
                  Spacer(),
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
                        PostDataClient().deletePost(widget.clientproduct);
                        Navigator.push(
                            (context),
                            MaterialPageRoute(
                                builder: (context) => ClientScreen()));
                        print("delete client");
                      });
                    },
                  ),
                ],
              ), //     child: Hero(tag: "${clientproduct.id}",   )
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 5),
          //   child: Text(
          //     // clientproducts is out demo list
          //     clientproduct.name,
          //   ),
          // ),
          // Text(
          //   "${clientproduct.postID}",
          //   style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          // )
        ],
      ),
    );
  }
}
