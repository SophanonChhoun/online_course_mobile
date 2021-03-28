import 'package:flutter/material.dart';
import 'package:online_tutorial/screens/profileinfo/edit_email.dart';
import 'package:online_tutorial/screens/profileinfo/edit_name.dart';
import 'package:online_tutorial/screens/profileinfo/edit_password.dart';
// import 'package:online_tutorial/components/profile_card_component.dart';

class ProfileInfo extends StatefulWidget {
  @override
  _ProfileInfoState createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }
}

_buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
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
      'Profile Information',
      style: TextStyle(
        color: Colors.black,
      ),
    ),
  );
}

_buildBody(BuildContext context) {
  return Column(
    children: [
      SizedBox(
        height: 100,
      ),
      Center(
        child: Container(
          margin: EdgeInsets.all(8),
          width: MediaQuery.of(context).size.width * 0.9,
          height: 100,
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Leav ChanDara",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    )
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  print("Edit name pressed");
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return NameEdit();
                  }));
                },
                icon: Icon(Icons.edit),
              ),
            ],
          ),
        ),
      ),
      Center(
        child: Container(
          margin: EdgeInsets.all(8),
          width: MediaQuery.of(context).size.width * 0.9,
          height: 100,
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "leav.dara@gmail.com",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    )
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  print("Edit email pressed");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return EmailEdit();
                    }),
                  );
                },
                icon: Icon(Icons.edit),
              ),
            ],
          ),
        ),
      ),
      Center(
        child: Container(
          margin: EdgeInsets.all(8),
          width: MediaQuery.of(context).size.width * 0.9,
          height: 100,
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Chnage Password",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "***********",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    )
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  print("Edit password pressed");
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return EditPassoword();
                  }));
                },
                icon: Icon(Icons.edit),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
