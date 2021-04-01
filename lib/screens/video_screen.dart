import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:online_tutorial/components/flare_markdown_style.dart';
import 'package:online_tutorial/models/lesson.dart';
import 'package:online_tutorial/models/lessondata.dart';
import 'package:online_tutorial/models/note.dart';
import 'package:online_tutorial/repos/lesson_repos.dart';
import 'package:online_tutorial/repos/note_repose.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'note_screen.dart';

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
  final noteRepo = NoteRepo();
  NoteData attachedNote;

  @override
  void initState() {
    super.initState();
    _lessonData = _lessonDataDatail.readLessonData(widget.videoid);
    preFetchNote();
  }

  preFetchNote() {
    attachedNote = null;
    noteRepo.getByLessonId(widget.videoid).then((note) {
      print("Pre-fetched note for lessons/${widget.videoid}");
      attachedNote = note;
    });
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
          widget.title,
          style: Theme.of(context).textTheme.headline2,
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => NoteView(
                          lessonId: widget.videoid,
                          preFetchedNote: attachedNote,
                          onClose: preFetchNote,
                        )));
              },
              child: Text("Notes"))
        ],
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
        Expanded(flex: 2, child: _buildOverviewContentContainer()),
      ],
    );
  }

  _buildOverviewContentContainer() {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
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
      child: _buildOverviewContent(),
      //_buildListView(context),
    );
  }

  _buildOverviewContent() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Overview",
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          Container(
            margin: EdgeInsets.all(8),
            height: 8,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              color: Color(0xFF7a7b7d),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: OverviewItem(),
          ),
        ],
      ),
    );
  }

  OverviewItem() {
    return Text(
      lesson.videoContent ?? "",
      style: Theme.of(context).textTheme.bodyText1,
    );
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
