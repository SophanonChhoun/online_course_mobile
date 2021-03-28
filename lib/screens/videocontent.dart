import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:online_tutorial/models/lesson.dart';
import 'package:online_tutorial/models/lesssondata.dart';
import 'package:online_tutorial/repos/lesson_repos.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
//import 'file:///A:/Flutter%20Test/youtubevideo/lib/screens/coursedetail.dart';

class VideoContent extends StatefulWidget {
  final int videoid;
  VideoContent({this.videoid});

  @override
  _VideoContentState createState() => _VideoContentState();
}

String CutURI(String URL) {
  // String str = 'HelloTutorialKart.';
  //
  int startIndex = 17;
  int endIndex = URL.length;

  //find substring
  String result = URL.substring(startIndex, endIndex);

  print(result);
  return result;
}

enum VideoContentDetail { overview, note }
VideoContentDetail selectDetail;

class _VideoContentState extends State<VideoContent> {
  YoutubePlayerController _controller;
  Future<LessonData> _lessonData;
  Lesson lesson;
  CourseDetailRepo _lessonDataDatail = CourseDetailRepo();
  @override
  void initState() {
    String URLID = CutURI("https://youtu.be/nJDHxHccYAo");
    super.initState();
    _lessonData = _lessonDataDatail.ReadLessonData(widget.videoid);
    print(_lessonData);
    _controller = YoutubePlayerController(
      initialVideoId: URLID, //tcodrIK2P_I
      params: const YoutubePlayerParams(
        // playlist: [
        //   ,
        // ],
        startAt: const Duration(minutes: 1, seconds: 36),
        showControls: true,
        showFullscreenButton: true,
        desktopMode: true,
        privacyEnhanced: true,
      ),
    );
    _controller.onEnterFullscreen = () {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      log('Entered Fullscreen');
    };
    _controller.onExitFullscreen = () {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      Future.delayed(const Duration(seconds: 1), () {
        _controller.play();
      });
      Future.delayed(const Duration(seconds: 5), () {
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      });
      log('Exited Fullscreen');
    };
  }

  @override
  Widget build(BuildContext context) {
    const player = YoutubePlayerIFrame();
    return YoutubePlayerControllerProvider(
      // Passing controller to widgets below.
      controller: _controller,
      child: Scaffold(
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
          title: const Text(
            'Welcome Come To the course',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: _buildBody(),
      ),
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
          return _buildView();
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  _buildView() {
    const player = YoutubePlayerIFrame();
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (kIsWeb && constraints.maxWidth > 800) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(child: player),
                    const SizedBox(
                      width: 500,
                      child: SingleChildScrollView(
                          //child: Controls(),
                          ),
                    ),
                  ],
                );
              }
              return ListView(
                children: [
                  player,
                  //const Controls(),
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
      lesson.videoContent,
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
    _controller.close();
    super.dispose();
  }
}
