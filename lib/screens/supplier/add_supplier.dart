import 'package:client_data/screens/supplier/supplier.dart';
import 'package:client_data/utils/customs/appTextForm.dart';
import 'package:client_data/utils/customs/customButton.dart';
import 'package:client_data/utils/default/default.dart';
import 'package:client_data/utils/supplier/model.dart';
import 'package:client_data/utils/supplier/post.dart';
import 'package:flutter/material.dart';

class AddSupp extends StatelessWidget {
  final String currentUserID;
  AddSupp(this.currentUserID);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultWidget(AddDetail(currentUserID), true, true, true, true),
    );
  }
}

TextEditingController name = TextEditingController();
TextEditingController ports = TextEditingController();
TextEditingController dest = TextEditingController();
TextEditingController offer = TextEditingController();

class AddDetail extends StatefulWidget {
  final String currentUserID;
  AddDetail(this.currentUserID);

  @override
  State<AddDetail> createState() => _AddDetailState();
}

class _AddDetailState extends State<AddDetail> with TickerProviderStateMixin {
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
        Navigator.push(
            (context),
            MaterialPageRoute(
                builder: (context) => SupplierScreen(widget.currentUserID)));
        setState(() {
          name.clear();
          ports.clear();
          dest.clear();
          offer.clear();
          inProgress = false;
        });
      });
    }

    return Column(
      children: [
        AppTextForm(cont: name, s: "Enter Supplier name", obscure: false),
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
                : Text("Add new Supplier"),
            func)
      ],
    );
  }

  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
