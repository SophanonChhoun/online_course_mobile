import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_tutorial/models/course.dart';
import 'package:online_tutorial/models/lesson.dart';
import 'package:online_tutorial/repos/course_repos.dart';
import 'package:online_tutorial/repos/lesson_repos.dart';
import 'package:online_tutorial/screens/home_screen.dart';
import 'package:online_tutorial/screens/text_lesson.dart';
import 'package:online_tutorial/screens/video_screen.dart';

class CourseDetailScreen extends StatefulWidget {
  final int id;
  CourseDetailScreen({this.id});
  @override
  _CourseDetailScreenState createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  Future<CourseDetailData> _courseData;
  CourseDetail _course;
  CourseDetailRepo courseRepo = CourseDetailRepo();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _courseData = courseRepo.readDataCourseDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody,
      appBar: AppBar(
        leading: Container(
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.black,
            //size: 24,
            icon: Icon(Icons.arrow_back),
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
    );
  }

  get _buildBody {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          _courseData = courseRepo.readDataCourseDetail(widget.id);
          // ignore: missing_return
        });
      },
      child: FutureBuilder<CourseDetailData>(
        future: _courseData,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("snapshot.error: ${snapshot.error}");
            return SafeArea(child: Text("Error while reading data"));
          }
          if (snapshot.connectionState == ConnectionState.done) {
            _course = snapshot.data.data;
            return _buildView();
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  header() {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: Color(0xFFF5F8FF),
            borderRadius: BorderRadius.circular(0.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // margin: EdgeInsetsGeometry.infinity.

                height: 180.0,
                width: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color(0xFFF5F8FF),
                  image: DecorationImage(
                    fit: BoxFit
                        .cover, //"https://u.cubeupload.com/rachnakeo/Calendar.png"
                    image: NetworkImage(_course.headerImage),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  headerdescribtion() {
    return CourseName();
  }

  CourseName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_course.title,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text(
              "${_course.duration} | ${_course.numberOfLessons} Lessons | ${_course.author.firstName} ${_course.author.lastName}",
              style: TextStyle(color: Color(0xFF909090)),
            )
          ],
        ),
        InkWell(
          onTap: () async {
            if (_course.enroll == false) {
              bool enroll = await courseRepo.writeEnrollCourse(widget.id);
              if (enroll) {
                setState(() {
                  _course.enroll = true;
                });
              } else {
                _showMyDialog();
              }
            } else {
              bool enroll = await courseRepo.deleteEnrollCourse(widget.id);
              if (enroll) {
                setState(() {
                  _course.enroll = false;
                });
              } else {
                _showMyDialog();
              }
            }
          },
          child: Container(
            width: 75.0,
            height: 35.0,
            decoration: BoxDecoration(
                color: _course.enroll ? Colors.redAccent : Color(0xFF02C39A),
                borderRadius: BorderRadius.circular(12.0)),
            child: Center(
              child: Text(
                "${_course.enroll ? "Unenroll" : "Enroll"}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  describtion() {
    return Container(
      padding: EdgeInsets.all(24),
      child: Text(
        _course.description,
        style: TextStyle(fontSize: 16.0, color: Color(0xff4A4E69)),
      ),
    );
  }

  contents() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      child: _buildListView(),
    );
  }

  _buildListView() {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: 24,
        ),
        InkWell(
          onTap: () {
            print("Child Pressed");
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Course Content",
                style: Theme.of(context).textTheme.headline1,
              ),
              SizedBox(
                height: 24,
              ),
              Column(
                children: List.generate(_course.lessons.length, (index) {
                  Lesson lesson = _course.lessons[index];
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          if (lesson.videoUrl == null) {
                            print("NUll");
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => TextLessonView(
                                  lessonId: lesson.id,
                                  lessonTitle: lesson.title,
                                ),
                              ),
                            );
                          } else {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => VideoContent(
                                  videoid: lesson.id,
                                  title: lesson.title,
                                ),
                              ),
                            );
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              lesson.videoUrl != null
                                  ? Icons.movie_creation
                                  : Icons.article,
                              color: Colors.grey,
                              size: 32.0,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: size.width - 150,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "${lesson.duration}mn",
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: size.width - 150,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      lesson.title,
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Text(
                              "${index + 1}",
                              style: Theme.of(context).textTheme.caption,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                    ],
                  );
                }),
              )
            ],
          ),
        ),
      ],
    );
  }

  _buildView() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header(),
              headerdescribtion(),
              describtion(),
              contents(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Hi! There is an error in enroll class. Please try again letter. Thank You<3.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
