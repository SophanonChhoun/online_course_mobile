import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:online_tutorial/components/flare_markdown_style.dart';
import 'package:online_tutorial/models/lesson.dart';
import 'package:online_tutorial/models/lessondata.dart';
import 'package:online_tutorial/repos/lesson_repos.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoContent extends StatefulWidget {
  final int videoid;
  final String title;
  VideoContent({this.videoid, this.title});

  @override
  _VideoContentState createState() => _VideoContentState();
}

enum VideoContentDetail { overview, note }
VideoContentDetail selectDetail;

class _VideoContentState extends State<VideoContent> {
  YoutubePlayerController _controller;
  Lesson lesson;
  CourseDetailRepo _lessonDataDatail = CourseDetailRepo();
  Future<LessonData> _lessonData;

  @override
  void initState() {
    super.initState();
    _lessonData = _lessonDataDatail.readLessonData(widget.videoid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        title: Text(
          widget.title ?? "",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return FutureBuilder<LessonData>(
      future: _lessonData,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print("snapshot.error: ${snapshot.error}");
          return SafeArea(child: Text("Error while reading data"));
        }
        if (snapshot.connectionState == ConnectionState.done) {
          lesson = snapshot.data.data;
          print(lesson.videoUrl);
          return _buildView();
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  _buildView() {
    String videoId;
    videoId = YoutubePlayer.convertUrlToId(lesson.videoUrl);
    print(videoId); // BBAyRBTfsOU
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );

    return Column(
      children: [
        Expanded(
          flex: 1,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const Expanded(child: player),
                  Expanded(
                    child: YoutubePlayerBuilder(
                      player: YoutubePlayer(
                        controller: _controller,
                      ),
                      builder: (context, player) {
                        return Column(
                          children: [
                            // some widgets
                            player,
                            //some other widgets
                          ],
                        );
                      },
                    ),
                  )
                ],
              );
            },
          ),
        ),
        Expanded(flex: 2, child: _buildOverviewContentContainer(context)),
      ],
    );
  }

  _buildOverviewContentContainer(context) {
    return Container(
      margin: EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        //color: Color(0xFFebf1ff),
        //color: Color(0xFFd0deff),
        //color: Color(0xFFe0eaff),
        color: Color(0xFFe3ecff),
        //color: Colors.grey,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: _buildOverviewContent(context),
      //_buildListView(context),
    );
  }

  _buildOverviewContent(context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: showWidget,
                child: Text(
                  "Overview",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: selectDetail == VideoContentDetail.overview
                        ? Colors.black
                        : Colors.grey,
                  ),
                ),
              ),
              InkWell(
                onTap: hideWidget,
                child: Text(
                  "Note",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: selectDetail == VideoContentDetail.note
                        ? Colors.black
                        : Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.all(8),
          height: 8,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            color: Color(0xFF7a7b7d),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        Visibility(
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          visible: viewVisible,
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFFe3ecff),
              //color: Colors.grey,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: selectDetail == VideoContentDetail.overview
                ? OverviewItem()
                : NoteItem(),
          ),
        ),
      ],
    );
  }

  OverviewItem() {
    return Text(
      lesson.videoContent ?? "",
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.black, fontSize: 16),
    );
  }

  NoteItem() {
    return Text(
      'NoteItem NoteItem NoteItem',
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.black, fontSize: 16),
    );
  }

  bool viewVisible = false;

  void showWidget() {
    setState(() {
      selectDetail = VideoContentDetail.overview;
      viewVisible = true;
    });
  }

  void hideWidget() {
    setState(() {
      selectDetail = VideoContentDetail.note;
      viewVisible = true;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }
}
