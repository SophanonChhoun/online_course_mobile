import 'package:flutter/material.dart';
import 'package:online_tutorial/models/data_message.dart';
import 'package:online_tutorial/models/user.dart';
import 'package:online_tutorial/repos/user_repos.dart';
import 'package:online_tutorial/screens/profileinfo/profile_info.dart';

class EditPassoword extends StatefulWidget {
  @override
  _EditPassowordState createState() => _EditPassowordState();
}

class _EditPassowordState extends State<EditPassoword> {
  var oldPassword = TextEditingController();
  var newPassword = TextEditingController();
  var confirmPassword = TextEditingController();
  UserRepo userRepo = UserRepo();
  int show = 0;
  String message = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            print("Back Pressed");
            Navigator.pop(context);
          },
          color: Colors.black,
          //size: 24,
          icon: Icon(Icons.arrow_back),
        ),
        title: const Text(
          'Update Password',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: _buildBody(context),
    );
  }

  _buildBody(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 400,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Enter Old Password",
                ),
                controller: oldPassword,
                obscureText: true,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter New Password',
                ),
                controller: newPassword,
                obscureText: true,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Confirm',
                ),
                controller: confirmPassword,
                obscureText: true,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "${show == 0 ? '' : message}",
                style: TextStyle(
                  color: show == 1 ? Colors.green : Colors.red,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  print(newPassword.text == confirmPassword.text);
                  if (newPassword.text != confirmPassword.text) {
                    setState(() {
                      show = 2;
                      message = "Your new and confirm password does not match";
                    });
                  } else {
                    dynamic data = userRepo
                        .updateUserPassword(newPassword.text, oldPassword.text)
                        .then((value) {
                      setState(() {
                        if (value.success == true) {
                          show = 1;
                          message = value.data;
                        } else {
                          show = 2;
                          message = value.data;
                        }
                      });
                    });
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      "Update",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
