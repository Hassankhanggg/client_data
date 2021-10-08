import 'package:client_data/screens/supplier/supplier.dart';
import 'package:client_data/utils/customs/appTextForm.dart';
import 'package:client_data/utils/customs/customButton.dart';
import 'package:client_data/utils/default/default.dart';
import 'package:client_data/utils/supplier/model.dart';
import 'package:client_data/utils/supplier/post.dart';
import 'package:flutter/material.dart';

class add_item extends StatelessWidget {
  String currentUserID;
  add_item(this.currentUserID);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: missing_required_param
      body: DefaultWidget(addDetail(currentUserID), true, true, true),
    );
  }
}

TextEditingController name = TextEditingController();
TextEditingController ports = TextEditingController();
TextEditingController dest = TextEditingController();
TextEditingController offer = TextEditingController();

class addDetail extends StatefulWidget {
  String currentUserID;
  addDetail(this.currentUserID);

  @override
  State<addDetail> createState() => _addDetailState();
}

class _addDetailState extends State<addDetail> with TickerProviderStateMixin {
  AnimationController controller;
  bool inProgress = false;
  String status = 'Reqiured';
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

  Widget build(BuildContext context) {
    void func() async {
      inProgress = true;
      var x = DonaloPost(
          cusName: name.text,
          offeredRate: int.parse(offer.text),
          ports: double.parse(ports.text),
          dest: dest.text);
      await PostData().post(x).then((value) {
        print('$value');
        Navigator.push((context),
            MaterialPageRoute(builder: (context) => SupplierScreen(widget.currentUserID)));
        inProgress = false;
      });
    }

    return Column(
      children: [
        AppTextForm(cont: name, s: "Enter your name", obscure: false),
        SizedBox(height: 30),
        AppTextForm(cont: ports, s: "Available ports", obscure: false),
        SizedBox(height: 30),
        AppTextForm(cont: dest, s: "Destination", obscure: false),
        SizedBox(height: 30),
        AppTextForm(cont: offer, s: "offered rate", obscure: false),
        SizedBox(height: 30),
        const SizedBox(height: 40),
        CustomButton(
            inProgress
                ? CircularProgressIndicator(
                    value: controller.value,
                    semanticsLabel: "Linear progress indicator",
                  )
                : Text("Add new Customer"),
            func)
      ],
    );
  }

  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
