import 'package:client_data/screens/clients/client.dart';
import 'package:client_data/screens/supplier/add_supplier.dart';
import 'package:client_data/utils/card.dart';
import 'package:client_data/utils/default/default.dart';
import 'package:client_data/utils/supplier/item_card.dart';
import 'package:client_data/utils/supplier/model.dart';
import 'package:client_data/utils/supplier/post.dart';
import 'package:flutter/material.dart';

class SupplierScreen extends StatelessWidget {
  SupplierScreen(this.currentUserID);
  final String currentUserID;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        body: DefaultWidget(Supplier(currentUserID), false, true, true, true),
      ),
    );
  }
}

BuildContext globalContext;

class Supplier extends StatelessWidget {
  Supplier(this.currentUserID);
  final String currentUserID;
  @override
  Widget build(BuildContext context) {
    print(currentUserID);
    Stream<List<DonaloPost>> l;
    double width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Row(
          children: [
            MaterialButton(
              color: Colors.cyan,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              onPressed: () {
                l = PostData().getPosts();
                print(l);
                Navigator.push(
                    (context),
                    MaterialPageRoute(
                        builder: (context) => AddSupp(currentUserID)));
              },
              child: Text(
                "Add Supplier",
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            MaterialButton(
              color: Colors.cyan,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              onPressed: () {
                Navigator.push(
                    (context),
                    MaterialPageRoute(
                        builder: (context) => ClientScreen(currentUserID)));
              },
              child: Text(
                "Client",
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            MaterialButton(
              color: Colors.cyan,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              onPressed: () {
                Navigator.push(
                    (context),
                    MaterialPageRoute(
                        builder: (context) => SupplierScreen(currentUserID)));
              },
              child: Text(
                "Supplier",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: cards.length * 120.0,
                child: StreamBuilder(
                  stream: PostData().getPosts(
                      flag: true, filter: "userID", key: currentUserID),
                  builder: (context, AsyncSnapshot<List<DonaloPost>> snapshot) {
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
                            childAspectRatio: width > 700
                                ? width / 1000 * 0.5
                                : width / 1000 * 1.5,
                          ),
                          itemBuilder: (context, index) => ItemCard(
                                currentUserID,
                                product: data[index],
                              ));
                    } else {
                      return Center(
                        child: Text('Loading...'),
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
    Navigator.push((globalContext),
        MaterialPageRoute(builder: (context) => AddSupp(currentUserID)));
  }
}
