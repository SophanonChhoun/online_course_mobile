import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:online_tutorial/models/course.dart';
import 'package:online_tutorial/repos/course_repos.dart';
import 'package:online_tutorial/screens/home_screen.dart';

class CourseDetail extends StatefulWidget {
  final Course item;
  CourseDetail({this.item});
  @override
  _CourseDetailState createState() => _CourseDetailState();
}

Future<CourseData> _userData;
List<Course> _userCourse;
Future<CourseData> _courseData;
List<Course> _course;

class _CourseDetailState extends State<CourseDetail> {
  Course item;
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
      backgroundColor: Color(0xFFF5F8FF),
      body: _buildBody(context, item),
    );
  }
}

_buildBody(BuildContext context, Course item) {
  return SafeArea(
    //backgroundColor: Colors.green,
    child: SafeArea(
      child: Column(
        children: [
          header(context, item),
          headerdescribtion(context),
          describtion(context),
          contents(context),
          //contents(context),
        ],
      ),
    ),
  );
}

header(BuildContext context, Course item) {
  return Row(
    children: [
      Container(
        height: 150.0,
        width: MediaQuery.of(context).size.width * 1,
        decoration: BoxDecoration(
          color: Color(0xFFF5F8FF),
          borderRadius: BorderRadius.circular(0.0),
          // image: DecorationImage(
          //   fit: BoxFit.cover,
          //   image: NetworkImage(
          //       "https://static.scientificamerican.com/sciam/cache/file/7A715AD8-449D-4B5A-ABA2C5D92D9B5A21_source.png"),
          // ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                child: IconButton(
              onPressed: () {
                print("Back Pressed");
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
              color: Colors.black,
              //size: 24,
              icon: Icon(Icons.arrow_back),
            )),
            Container(
              // margin: EdgeInsetsGeometry.infinity.
              margin: new EdgeInsets.only(left: 10, top: 5),
              height: 140.0,
              width: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Color(0xFFF5F8FF),
                image: DecorationImage(
                  fit: BoxFit
                      .cover, //"https://u.cubeupload.com/rachnakeo/Calendar.png"
                  image: NetworkImage(
                      "https://u.cubeupload.com/rachnakeo/Calendar.png"),
                ),
              ),
            )
          ],
        ),
      )
    ],
  );
}

headerdescribtion(BuildContext context) {
  return CourseName();
}

CourseName() {
  return Padding(
    padding: const EdgeInsets.all(24.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Data Maintanent",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text(
              "1 Hour | 12 Lessons | Hy Sothyrith",
              style: TextStyle(color: Color(0xFF909090)),
            )
          ],
        ),
        InkWell(
          onTap: () {
            print("Enroll pressed");
          },
          child: Container(
              width: 75.0,
              height: 35.0,
              decoration: BoxDecoration(
                  color: Color(0xFF02C39A),
                  borderRadius: BorderRadius.circular(12.0)),
              child: Center(
                  child: Text(
                "Enroll",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ))),
        ),
      ],
    ),
  );
}

describtion(context) {
  return Container(
    padding: EdgeInsets.all(20),
    child: Text(
      "In SQL, dates are complicated for newbies, since while working with database, the format of the date in table must be matched with the input date in order to insert.",
      style: TextStyle(fontSize: 16.0, color: Color(0xff4A4E69)),
    ),
  );
}

contents(context) {
  return Expanded(
    child: Container(
      decoration: BoxDecoration(
        //color: Color(0xFFebf1ff),
        //color: Color(0xFFd0deff),
        //color: Color(0xFFe0eaff),
        color: Color(0xFFe3ecff),
        //color: Colors.grey,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      child: _buildListView(context),
    ),
  );
}

_buildListView(context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ListView(
      scrollDirection: Axis.vertical,
      children: [
        SizedBox(
          height: 32,
        ),
        InkWell(
          onTap: () {
            print("Child Pressed");
          },
          child: Container(
            // color: Colors.lightGreen,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.movie_creation,
                  color: Colors.grey,
                  size: 32.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "5mn",
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      "Welcome to Course",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Text(
                  "1",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    ),
  );
}
