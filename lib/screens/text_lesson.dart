import 'package:online_tutorial/components/flare_markdown_style.dart';
import 'package:online_tutorial/models/lesson.dart';
import 'package:online_tutorial/models/lessondata.dart';
import 'package:online_tutorial/repos/lesson_repos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class TextLessonView extends StatefulWidget {
  final int lessonId;
  final String lessonTitle;

  TextLessonView({this.lessonId, this.lessonTitle = ""});

  @override
  _TextLessonViewState createState() => _TextLessonViewState();
}

class _TextLessonViewState extends State<TextLessonView> {
  CourseDetailRepo _lessonDataDatail = CourseDetailRepo();
  Future<LessonData> _lessonData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _lessonData = _lessonDataDatail.readLessonData(widget.lessonId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          widget.lessonTitle,
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body: FutureBuilder<LessonData>(
        future: _lessonData,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Error loading course details");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            Lesson lesson = snapshot.data.data;

            return Markdown(
                data: lesson.textContent,
                styleSheet: getFlareMarkdownStyle(context));
          } else {
            return Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
