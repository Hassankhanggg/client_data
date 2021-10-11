import 'package:client_data/screens/clients/client.dart';
import 'package:client_data/screens/supplier/supplier.dart';
import 'package:client_data/utils/default/default.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SelectScreen extends StatelessWidget {
  final String currentUserID;
  SelectScreen({Key key, this.currentUserID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultWidget(
          Select(currentUserID: currentUserID), true, true, true, true),
    );
  }
}

class Select extends StatefulWidget {
  final String currentUserID;

  // String userID = widget.userID;
  Select({this.currentUserID});
  // String uID = userID;
  //String userID = widget.userID;
  @override
  State<Select> createState() => _SelectState(currentUserID);
}

class _SelectState extends State<Select> with TickerProviderStateMixin {
  AnimationController controller;
  bool inProgress = false;
  bool inProgress1 = false;

  _SelectState(String userID);
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
                              "Supplier",
                              style: TextStyle(color: Colors.white),
                            ))),
              onPressed: () {
                inProgress = true;
                Navigator.push(
                    (context),
                    MaterialPageRoute(
                        builder: (context) =>
                            SupplierScreen(widget.currentUserID)));
                inProgress = false;
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.cyan,
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
              primary: Colors.cyan,
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
