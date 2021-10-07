import 'package:client_data/screens/UserScreen.dart';
import 'package:client_data/screens/client.dart';
import 'package:client_data/screens/select.dart';
import 'package:client_data/utils/PostUser.dart';
import 'package:client_data/utils/appTextForm.dart';
import 'package:client_data/utils/customButton.dart';
import 'package:client_data/utils/default.dart';
import 'package:client_data/utils/model%20user.dart';
import 'package:flutter/material.dart';

class addUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: missing_required_param
      body: DefaultWidget(addDetailUser(), true, true, true),
    );
  }
} //store user,table,

TextEditingController name = TextEditingController();
TextEditingController ports = TextEditingController();
TextEditingController email = TextEditingController();
TextEditingController offer = TextEditingController();

class addDetailUser extends StatefulWidget {
  @override
  State<addDetailUser> createState() => _addDetailUserState();
}

class _addDetailUserState extends State<addDetailUser>
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
      var x = DonaloPostUser(
          Name: name.text,
          // offeredRate: int.parse(offer.text),
          // ports: double.parse(ports.text),
          email: email.text);
      await PostDataUser().post(x).then((value) {
        print('$value');
        Navigator.push(
            (context), MaterialPageRoute(builder: (context) => UserScreen()));
        inProgress = false;
      });
    }

    return Column(
      children: [
        AppTextForm(cont: name, s: "Enter User name", obscure: false),
        SizedBox(height: 30),
        AppTextForm(cont: ports, s: "Available ports", obscure: false),
        SizedBox(height: 30),
        AppTextForm(cont: email, s: "emailination", obscure: false),
        SizedBox(height: 30),
        AppTextForm(cont: offer, s: "offered rate", obscure: false),
        SizedBox(height: 30),
        SizedBox(height: 40),
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
