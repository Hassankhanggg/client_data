import 'package:client_data/screens/clients/client.dart';
import 'package:client_data/screens/supplier/supplier.dart';
import 'package:client_data/utils/default/default.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SelectScreen extends StatelessWidget {
  String currentUserID;
  SelectScreen({Key key, this.currentUserID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          DefaultWidget(select(currentUserID: currentUserID), true, true, true),
    );
  }
}

class select extends StatefulWidget {
  String currentUserID;

  // String userID = widget.userID;
  select({this.currentUserID});
  // String uID = userID;
  //String userID = widget.userID;
  @override
  State<select> createState() => _selectState(currentUserID);
}

class _selectState extends State<select> with TickerProviderStateMixin {
  AnimationController controller;
  bool inProgress = false;
  bool inProgress1 = false;

  _selectState(String userID);
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("select : " + widget.currentUserID);
    return Container(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: ElevatedButton(
              child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Center(
                      child: inProgress
                          ? CircularProgressIndicator(
                              value: controller.value * 2,
                              semanticsLabel: 'Linear progress indicator',
                            )
                          : Text(
                              "SUPPLIER",
                              style: TextStyle(color: Colors.white),
                            ))),
              onPressed: () {
                inProgress = true;
                Navigator.push(
                    (context),
                    MaterialPageRoute(
                        builder: (context) => SupplierScreen(widget.currentUserID)));
                inProgress = false;
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
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            child: SizedBox(
                width: double.infinity,
                height: 50,
                child: Center(
                    child: inProgress1
                        ? CircularProgressIndicator(
                            value: controller.value,
                            semanticsLabel: 'Linear progress indicator',
                          )
                        : Text(
                            "Client",
                            style: TextStyle(color: Colors.white),
                          ))),
            onPressed: () {
              inProgress1 = true;
              Navigator.push(
                  (context),
                  MaterialPageRoute(
                      builder: (context) =>
                          ClientScreen(widget.currentUserID)));
              inProgress1 = false;
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.deepPurple,
              onPrimary: Colors.redAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
