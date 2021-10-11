import 'package:client_data/authentication/authentication_service.dart';
import 'package:client_data/authentication/signin.dart';
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

void showDialogs() {
  // flutter defined function
  showDialog(
    context: gcontext,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        backgroundColor: Colors.cyan[100],
        elevation: .4,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
        contentPadding: EdgeInsets.only(top: 10.0),
        title: new Text("Family Communications web app"),
        content: new Text("   any details about family "),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text("Close"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
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
    return Container(
      color: Colors.black12,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: Container(
          // color: Colors.cyan,
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
                "Family Communication",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
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
                  MaterialButton(
                    color: Colors.cyan,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    onPressed: () {
                      showDialogs();
                    },
                    child: Text(
                      "About Us",
                      style: TextStyle(color: Colors.white),
                    ),
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
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => signin()),
                                (Route<dynamic> route) => false);
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
            "Family Communications",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.cyanAccent,
                fontSize: 30),
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
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => signin()),
                              (Route<dynamic> route) => false);
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
