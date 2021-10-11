import 'package:client_data/utils/default/Navbar.dart';
import 'package:flutter/material.dart';

class DefaultWidget extends StatelessWidget {
  final bool showBackicon;
  final Widget widget;
  final bool showimage;
  final bool showHome;
  final bool showlogout;
  DefaultWidget(this.widget, this.showimage, this.showlogout, this.showBackicon,
      this.showHome);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black12,
                Colors.white54,
                Colors.white60,
                Colors.white70,
              ]),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Navbar(showlogout, showBackicon, showHome),
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
      SizedBox(
        height: 600,
      ),
    ];
  }
}
