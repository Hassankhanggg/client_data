import 'package:client_data/utils/Navbar.dart';
import 'package:flutter/material.dart';

class defaultWidget extends StatelessWidget {
  bool showBackicon;
  Widget widget;
  bool showimage;
  bool showlogout;
  defaultWidget(@required this.widget, this.showimage, this.showlogout,
      this.showBackicon);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        // alignment: AlignmentGeometry,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.black, Colors.black87, Colors.blueGrey.shade900,
                Colors.deepPurple
                // Color.fromRGBO(90, 20, 120, 1.0),
                // Color.fromRGBO(36, 11, 54, 1.0)
              ]),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Navbar(showlogout, showBackicon),
              Padding(
                padding: const EdgeInsets.symmetric(),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth > 800) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: pageChildren(
                            constraints.biggest.width / 2, context),
                      );
                    } else {
                      return Column(
                        children:
                            pageChildren(constraints.biggest.width, context),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> pageChildren(double width, BuildContext context) {
    return <Widget>[
      showimage
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Image.asset(
                "assets/images/lp_image.png",
                width: width,
                //fit: BoxFit.cover,
              ),
            )
          : Text(''),
      Container(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: widget,
            )
          ],
        ),
      ),
    ];
  }
}
