import 'package:flutter/material.dart';
import 'package:online_tutorial/repos/user_repos.dart';
import 'package:online_tutorial/screens/profileinfo/profile_info.dart';

class EmailEdit extends StatefulWidget {
  final String email;

  const EmailEdit({Key key, this.email}) : super(key: key);

  @override
  _EmailEditState createState() => _EmailEditState();
}

class _EmailEditState extends State<EmailEdit> {
  var emailCtrl = TextEditingController();
  UserRepo userRepo = UserRepo();
  bool show = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailCtrl.text = widget.email;
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
          'Edit Email',
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
        height: 300,
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
                  labelText: 'Your Email',
                ),
                controller: emailCtrl,
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                "${show == true ? "Your email have already updated" : ""}",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 80,
              ),
              InkWell(
                onTap: () {
                  userRepo.updateUserEmail(emailCtrl.text).then(
                    (value) {
                      setState(
                        () {
                          print(value);
                          if (value == true) {
                            show = true;
                          }
                        },
                      );
                    },
                  );
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
