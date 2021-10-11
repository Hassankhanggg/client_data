import 'package:client_data/screens/users/UserScreen.dart';
import 'package:client_data/utils/user%20utils/PostUser.dart';
import 'package:client_data/utils/customs/appTextForm.dart';
import 'package:client_data/utils/customs/customButton.dart';
import 'package:client_data/utils/default/default.dart';
import 'package:client_data/utils/user%20utils/model%20user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class addUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultWidget(addDetailUser(), true, true, true, true),
    );
  }
}

TextEditingController name = TextEditingController();

TextEditingController email = TextEditingController();

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
      FirebaseAuth _auth = FirebaseAuth.instance;
      var x = DonaloPostUser(
          Name: name.text, userID: _auth.currentUser.uid, email: email.text);
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
        AppTextForm(cont: email, s: "email", obscure: false),
        SizedBox(height: 30),
        SizedBox(height: 40),
        CustomButton(
            inProgress
                ? CircularProgressIndicator(
                    value: controller.value,
                    semanticsLabel: "Linear progress indicator",
                  )
                : Text("Add new User"),
            func)
      ],
    );
  }

  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
