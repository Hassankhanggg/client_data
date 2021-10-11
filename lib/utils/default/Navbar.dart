import 'package:client_data/authentication/authentication_service.dart';
import 'package:client_data/screens/users/UserScreen.dart';
import 'package:client_data/utils/customs/customButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:provider/src/provider.dart';

BuildContext gcontext;

class Navbar extends StatelessWidget {
  Navbar(this.showlogout, this.showBackicon, this.showHome);
  bool showHome;
  bool showBackicon;
  bool showlogout;
  @override
  Widget build(BuildContext context) {
    gcontext = context;
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return DesktopNavbar(showlogout, showBackicon, showHome);
        } else if (constraints.maxWidth > 800 && constraints.maxWidth < 1200) {
          return DesktopNavbar(showlogout, showBackicon, showHome);
        } else {
          return MobileNavbar(showlogout, showBackicon, showHome);
        }
      },
    );
  }
}

class DesktopNavbar extends StatelessWidget {
  bool showBackicon;
  final bool showlogout;
  bool showHome;

  DesktopNavbar(this.showlogout, this.showBackicon, this.showHome)
      : assert(showBackicon != null),
        assert(showlogout != null);

  @override
  Widget build(BuildContext context) {
    void homeFunc() {
      Navigator.push(
          (context), MaterialPageRoute(builder: (context) => UserScreen()));
    }

    showBackicon = false;
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
                showHome
                    ? MaterialButton(
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        onPressed: () {
                          homeFunc();
                        },
                        child: Text(
                          "Home",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    : Text(''),
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
                          "Logout",
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
  bool showHome;
  MobileNavbar(this.showlogout, this.showBackicon, this.showHome);

  @override
  Widget build(BuildContext context) {
    void homeFunc() {
      Navigator.push(
          (context), MaterialPageRoute(builder: (context) => UserScreen()));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Container(
        child: Column(children: <Widget>[
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
                showHome
                    ? MaterialButton(
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        onPressed: () {
                          homeFunc();
                        },
                        child: Text(
                          "Home",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    : Text(''),
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
