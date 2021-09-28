import 'package:client_data/utils/model.dart';
import 'package:client_data/utils/post.dart';
import 'package:flutter/material.dart';

class customButton extends StatelessWidget {
  customButton(this.s, this.func);
  Widget s;
  Function func;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: ElevatedButton(
        child: SizedBox(width: 300, height: 50, child: Center(child: s)),
        onPressed: () async {
          func();
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.deepPurple,
          onPrimary: Colors.redAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}

class ProgressButton extends StatefulWidget {
// ProgressButton();

  @override
  _ProgressButtonState createState() => _ProgressButtonState();
}

class _ProgressButtonState extends State<ProgressButton>
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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: ElevatedButton(
        child: SizedBox(
            width: 300,
            height: 50,
            child: Center(
                child: CircularProgressIndicator(
              value: controller.value,
              semanticsLabel: "Linear progress indicator",
            ))),
        onPressed: () {
          // widget.func();
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.deepPurple,
          onPrimary: Colors.redAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
