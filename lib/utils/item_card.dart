import 'package:client_data/screens/supplier.dart';
import 'package:client_data/utils/card.dart';
import 'package:client_data/utils/model.dart';
import 'package:client_data/utils/post.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatefulWidget {
  final DonaloPost product;
  const ItemCard({
    Key key,
    this.product,
  }) : super(key: key);

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
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
                  Text("${widget.product.cusName}"),
                  SizedBox(height: 5),
                  Text("Ports:" + widget.product.ports.toString()),
                  SizedBox(height: 5),
                  Text(widget.product.dest),
                  SizedBox(height: 5),
                  Text("Rate: ${widget.product.offeredRate.toString()}"),
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
                        PostData().deletePost(widget.product);
                        Navigator.push(
                            (context),
                            MaterialPageRoute(
                                builder: (context) => SupplierScreen()));
                        print("delete");
                      });
                    },
                  ),
                ],
              ), //     child: Hero(tag: "${product.id}",   )
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 5),
          //   child: Text(
          //     // products is out demo list
          //     product.name,
          //   ),
          // ),
          // Text(
          //   "${product.postID}",
          //   style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          // )
        ],
      ),
    );
  }
}
