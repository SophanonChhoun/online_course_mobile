import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_tutorial/components/card_component.dart';
import 'package:online_tutorial/components/drawer_component.dart';
import 'package:online_tutorial/models/course.dart';
import 'package:online_tutorial/repos/course_repos.dart';
import 'package:online_tutorial/screens/coursedetail.dart';
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
  CourseRepo courseRepo = CourseRepo();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userData = courseRepo.readDataUserCourse();
    _courseData = courseRepo.readDataAllCourse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      drawer: DrawerComponent(),
      body: _buildBody,
    );
  }

  get _buildBody {
    var size = MediaQuery.of(context).size;

    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          _userData = courseRepo.readDataUserCourse();
          _courseData = courseRepo.readDataAllCourse();
        });
      },
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.only(left: 24, top: 24, bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildUserCourse,
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.only(right: 24),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "More Courses",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(
                                    builder: (context) => ListScreen()))
                                .then((value) {
                              setState(() {
                                _userData = courseRepo.readDataUserCourse();
                                _courseData = courseRepo.readDataAllCourse();
                              });
                            });
                          },
                          child: Text(
                            "See all",
                            style: TextStyle(
                              color: Colors.green,
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
                    ),
                  ],
                ),
              )
            ],
          ),
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
          return Center(
            child: Text("Error please try again"),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          _userCourse = snapshot.data.data;
          if (_userCourse.length > 0) {
            return buildUserCourseRow();
          } else {
            return SizedBox(
              height: 0,
            );
          }
        } else {
          return buildWaitCourseUser();
        }
      },
    );
  }

  buildWaitCourseUser() {
    var size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text(
            "Your courses",
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(5, (index) {
              return buildWaitCourse();
            }),
          ),
        )
      ],
    );
  }

  buildWaitAllCourse() {
    var size = MediaQuery.of(context).size;

    return Wrap(
      runSpacing: 20,
      spacing: 10,
      children: List.generate(10, (index) {
        return buildWaitCourse();
      }),
    );
  }

  buildWaitCourse() {
    var size = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: (size.width / 2) - 40,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
        ),
      ),
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
          return buildWaitAllCourse();
        }
      },
    );
  }

  buildUserCourseRow() {
    var size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text(
            "${_userCourse.length > 0 ? 'Your courses' : ''}",
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(_userCourse.length, (index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .push(
                            MaterialPageRoute(
                              builder: (context) => CourseDetailScreen(
                                id: _userCourse[index].id,
                              ),
                            ),
                          )
                              .then((value) {
                            setState(() {
                              _userData = courseRepo.readDataUserCourse();
                              _courseData = courseRepo.readDataAllCourse();
                            });
                          });
                        },
                        child: CardComponent(
                          width: (size.width / 2) - 40,
                          height: 200,
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
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }

  buildCourse() {
    var size = MediaQuery.of(context).size;

    return Wrap(
      runSpacing: 20,
      spacing: 10,
      children: List.generate(_course.length, (index) {
        return InkWell(
          onTap: () {
            Navigator.of(context)
                .push(
              MaterialPageRoute(
                builder: (context) => CourseDetailScreen(
                  id: _course[index].id,
                ),
              ),
            )
                .then((value) {
              setState(() {
                _userData = courseRepo.readDataUserCourse();
                _courseData = courseRepo.readDataAllCourse();
              });
            });
          },
          child: CardComponent(
            width: (size.width / 2) - 40,
            height: 200,
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
