import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_tutorial/components/card_component.dart';
import 'package:online_tutorial/models/course.dart';
import 'package:online_tutorial/repos/course_repos.dart';
import 'package:online_tutorial/screens/list_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<CourseData> _userData;
  List<Course> _userCourse;
  Future<CourseData> _courseData;
  List<Course> _course;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userData = readDataUserCourse();
    _courseData = readDataAllCourse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            scaffoldKey.currentState.openDrawer();
          },
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.only(left: 30),
          children: <Widget>[
            SizedBox(
              height: 200,
            ),
            InkWell(
              onTap: () {},
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
              onTap: () {},
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
              onTap: () {},
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
              onTap: () {},
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
                        "Settings",
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
          ],
        ),
      ),
      body: _buildBody,
    );
  }

  get _buildBody {
    var size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        color: Colors.blueGrey.shade50,
        padding: EdgeInsets.only(left: 16, top: 16, bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Your courses",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 33,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: buildUserCourse,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(right: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "More Courses",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 33,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ListScreen()));
                        },
                        child: Text(
                          "See all",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.greenAccent,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: buildAllCourse,
                  )
                  // Wrap(
                  //   runSpacing: 20,
                  //   spacing: 10,
                  //   children: buildAllCourse,
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  get buildUserCourse {
    return FutureBuilder<CourseData>(
      future: _userData,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print("snapshot.error: ${snapshot.error}");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          // print(snapshot.data.success);
          // print(snapshot.data.data[0].title);
          _userCourse = snapshot.data.data;
          return buildUserCourseRow();
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  get buildAllCourse {
    return FutureBuilder<CourseData>(
      future: _courseData,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print("snapshot.error: ${snapshot.error}");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          _course = snapshot.data.data;
          return buildCourse();
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  buildUserCourseRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(_userCourse.length, (index) {
        return Row(
          children: [
            InkWell(
              onTap: () {},
              child: CardComponent(
                width: 170,
                height: 240,
                header_img: _userCourse[index].headerImg,
                title: _userCourse[index].title,
                lesson: _userCourse[index].numberOfLessons,
                duration: _userCourse[index].duration,
              ),
            ),
            SizedBox(
              width: 5,
            ),
          ],
        );
      }),
    );
  }

  buildCourse() {
    return Wrap(
      runSpacing: 20,
      spacing: 10,
      children: List.generate(_course.length, (index) {
        return InkWell(
          onTap: () {},
          child: CardComponent(
            width: 170,
            height: 240,
            header_img: _course[index].headerImg,
            title: _course[index].title,
            lesson: _course[index].numberOfLessons,
            duration: _course[index].duration,
          ),
        );
      }),
    );
  }
}