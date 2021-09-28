import 'package:client_data/screens/client.dart';
import 'package:client_data/screens/supplier.dart';
import 'package:client_data/utils/PostClient.dart';
import 'package:client_data/utils/appTextForm.dart';
import 'package:client_data/utils/customButton.dart';
import 'package:client_data/utils/default.dart';
import 'package:client_data/utils/model.dart';
import 'package:client_data/utils/modelclient.dart';
import 'package:client_data/utils/post.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class addClient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: missing_required_param
      body: defaultWidget(addDetailClient(), true, true, true),
    );
  }
}

TextEditingController name = TextEditingController();
TextEditingController ports = TextEditingController();
TextEditingController dest = TextEditingController();
TextEditingController offer = TextEditingController();

class addDetailClient extends StatefulWidget {
  @override
  State<addDetailClient> createState() => _addDetailClientState();
}

class _addDetailClientState extends State<addDetailClient>
    with TickerProviderStateMixin {
  AnimationController controller;
  bool inProgress = false;
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
      var x = DonaloPostClient(
          cusName: name.text,
          offeredRate: int.parse(offer.text),
          ports: double.parse(ports.text),
          dest: dest.text);
      await PostDataClient().post(x).then((value) {
        print('$value');
        Navigator.push(
            (context), MaterialPageRoute(builder: (context) => ClientScreen()));
        inProgress = false;
      });
    }

    return Column(
      children: [
        appTextForm(cont: name, s: "Enter client name", obscure: false),
        SizedBox(height: 30),
        appTextForm(cont: ports, s: "Available ports", obscure: false),
        SizedBox(height: 30),
        appTextForm(cont: dest, s: "Destination", obscure: false),
        SizedBox(height: 30),
        appTextForm(cont: offer, s: "offered rate", obscure: false),
        SizedBox(height: 30),
        SizedBox(height: 40),
        customButton(
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
