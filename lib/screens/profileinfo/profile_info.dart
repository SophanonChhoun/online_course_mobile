import 'package:flutter/material.dart';
import 'package:online_tutorial/models/user.dart';
import 'package:online_tutorial/repos/user_repos.dart';
import 'package:online_tutorial/screens/home_screen.dart';
import 'package:online_tutorial/screens/profileinfo/edit_email.dart';
import 'package:online_tutorial/screens/profileinfo/edit_name.dart';
import 'package:online_tutorial/screens/profileinfo/edit_password.dart';
// import 'package:online_tutorial/components/profile_card_component.dart';

class ProfileInfo extends StatefulWidget {
  @override
  _ProfileInfoState createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  UserRepo userRepo = UserRepo();
  Future<UserData> _userData;
  User user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userData = userRepo.readDataUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildFuture(),
    );
  }

  _buildFuture() {
    return FutureBuilder<UserData>(
      future: _userData,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print("snapshot.error: ${snapshot.error}");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          // print(snapshot.data.success);
          // print(snapshot.data.data[0].title);
          user = snapshot.data.data;
          return _buildBody();
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  _buildAppBar() {
    return AppBar(
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
        'Profile Information',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }

  _buildBody() {
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
                        "${user.firstName} ${user.lastName}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      )
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    print("Edit name pressed");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return NameEdit(
                        firstName: user.firstName,
                        lastName: user.lastName,
                      );
                    })).then((value) {
                      setState(() {
                        _userData = userRepo.readDataUser();
                      });
                    });
                  },
                  icon: Icon(Icons.edit),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 24,
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
                        "${user.email}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
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
                        return EmailEdit(
                          email: user.email,
                        );
                      }),
                    ).then((value) {
                      setState(() {
                        _userData = userRepo.readDataUser();
                      });
                    });
                  },
                  icon: Icon(Icons.edit),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 24,
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
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      )
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    print("Edit password pressed");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return EditPassoword();
                    })).then((value) {
                      setState(() {
                        _userData = userRepo.readDataUser();
                      });
                    });
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
}
