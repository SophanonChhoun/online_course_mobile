import 'package:flutter/material.dart';
import 'package:online_tutorial/repos/user_repos.dart';
import 'package:online_tutorial/screens/profileinfo/profile_info.dart';

class NameEdit extends StatefulWidget {
  final String firstName;
  final String lastName;

  const NameEdit({Key key, this.firstName, this.lastName}) : super(key: key);

  @override
  _NameEditState createState() => _NameEditState();
}

class _NameEditState extends State<NameEdit> {
  UserRepo userRepo = UserRepo();
  var firstNameCtrl = TextEditingController();
  var lastNameCtrl = TextEditingController();
  bool show = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstNameCtrl.text = widget.firstName;
    lastNameCtrl.text = widget.lastName;
  }

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
          'Edit Name',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
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
                  labelText: 'First Name',
                ),
                controller: firstNameCtrl,
              ),
              SizedBox(
                height: 24,
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Last Name',
                ),
                controller: lastNameCtrl,
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                "${show == true ? "Your name already update" : ""}",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 80,
              ),
              InkWell(
                onTap: () {
                  userRepo
                      .updateUserName(firstNameCtrl.text, lastNameCtrl.text)
                      .then((value) {
                    if (value == true) {
                      setState(() {
                        show = true;
                      });
                    }
                  });
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
