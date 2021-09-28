import 'package:client_data/screens/add_supplier.dart';
import 'package:client_data/screens/select.dart';
import 'package:client_data/utils/card.dart';
import 'package:client_data/utils/customButton.dart';
import 'package:client_data/utils/default.dart';
import 'package:client_data/utils/item_card.dart';
import 'package:client_data/utils/model.dart';
import 'package:client_data/utils/post.dart';
import 'package:flutter/material.dart';

// return WillPopScope(
//   onWillPop: () async => true,
//   child: Scaffold(
class SupplierScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _scaffold,
      body: defaultWidget(supplier(), false, true, true),
    );
  }
}

BuildContext globalContext;

class supplier extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Stream<List<DonaloPost>> l;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        // customButton("Add new customer", func),
        ElevatedButton(
          child: const SizedBox(
              width: 190,
              height: 50,
              child: Center(
                  child: Text(
                "add new person",
                style: TextStyle(color: Colors.white),
              ))),
          onPressed: () {
            l = PostData().getPosts();
            print(l);
            Navigator.push(
                (context), MaterialPageRoute(builder: (context) => add_item()));
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.purple.shade900,
            onPrimary: Colors.redAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
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
                  stream: PostData().getPosts(),
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
                            childAspectRatio: //big                 //small
                                width > 700
                                    ? width / 1000 * 0.5
                                    : width / 1000 * 1.5,
                          ),
                          itemBuilder: (context, index) => ItemCard(
                                product: data[index],
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
        (globalContext), MaterialPageRoute(builder: (context) => add_item()));
  }
}
