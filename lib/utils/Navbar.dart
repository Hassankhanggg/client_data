import 'package:client_data/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class Navbar extends StatelessWidget {
  Navbar(@required this.showlogout, this.showBackicon);
  bool showBackicon;
  bool showlogout;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return DesktopNavbar(showlogout, showBackicon);
        } else if (constraints.maxWidth > 800 && constraints.maxWidth < 1200) {
          return DesktopNavbar(showlogout, showBackicon);
        } else {
          return MobileNavbar(showlogout, showBackicon);
        }
      },
    );
  }
}

class DesktopNavbar extends StatelessWidget {
  bool showBackicon;
  bool showlogout;

  DesktopNavbar(this.showlogout, this.showBackicon)
      : assert(showBackicon != null),
        assert(showlogout != null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            showBackicon
                ? IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ))
                : Text(''),
            SizedBox(
              width: 10,
            ),
            Text(
              "Data Center",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 30),
            ),
            Spacer(),
            Row(
              children: <Widget>[
                Text(
                  "Home",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  width: 30,
                ),
                Text(
                  "About Us",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  width: 30,
                ),
                Text(
                  "Portfolio",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  width: 30,
                ),
                showlogout
                    ? MaterialButton(
                        color: Colors.pink,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        onPressed: () {
                          context
                              .read<AuthenticationService>()
                              .signOut(context);
                        },
                        child: Text(
                          "logout",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    : Text('')
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MobileNavbar extends StatelessWidget {
  bool showBackicon;
  bool showlogout;
  MobileNavbar(this.showlogout, this.showBackicon);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Container(
        child: Column(children: <Widget>[
          showBackicon
              ? IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ))
              : Text(''),
          SizedBox(
            width: 10,
          ),
          Text(
            "Data center",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 30),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Home",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  width: 30,
                ),
                Text(
                  "About Us",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  width: 30,
                ),
                showlogout
                    ? MaterialButton(
                        color: Colors.pink,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        onPressed: () {
                          context
                              .read<AuthenticationService>()
                              .signOut(context);
                        },
                        child: Text(
                          "logout",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    : Text('')
              ],
            ),
          )
        ]),
      ),
    );
  }
}
