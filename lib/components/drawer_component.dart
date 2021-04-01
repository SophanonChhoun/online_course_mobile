import 'package:flutter/material.dart';
import 'package:online_tutorial/repos/auth.dart';
import 'package:online_tutorial/screens/account_screen.dart';
import 'package:online_tutorial/screens/my_notes.dart';
import 'package:online_tutorial/screens/profileinfo/profile_info.dart';
import 'package:online_tutorial/screens/sign_in_screen.dart';
import 'package:online_tutorial/screens/user_course_screen.dart';

class DrawerComponent extends StatefulWidget {
  @override
  _DrawerComponentState createState() => _DrawerComponentState();
}

class _DrawerComponentState extends State<DrawerComponent> {
  AuthRepo authRepo = new AuthRepo();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.only(left: 30),
        children: <Widget>[
          SizedBox(
            height: 200,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => UserCourse()));
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                bottom: BorderSide(
                  color: Color(0xFFD0DEFF),
                ),
              )),
              child: Container(
                padding: EdgeInsets.all(8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "My courses",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Color(0xFFD0DEFF),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => MyNotesView()));
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                bottom: BorderSide(
                  color: Color(0xFFD0DEFF),
                ),
              )),
              child: Container(
                padding: EdgeInsets.all(8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "My notes",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Color(0xFFD0DEFF),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return SettingsPage();
                  },
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                bottom: BorderSide(
                  color: Color(0xFFD0DEFF),
                ),
              )),
              child: Container(
                padding: EdgeInsets.all(8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Accounts",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Color(0xFFD0DEFF),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          InkWell(
            onTap: () {
              authRepo.signOut().then((value) {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => SignInScreen()));
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                bottom: BorderSide(
                  color: Color(0xFFD0DEFF),
                ),
              )),
              child: Container(
                padding: EdgeInsets.all(8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Log Out",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Color(0xFFD0DEFF),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
