import 'package:flutter/material.dart';

class CardComponent extends StatefulWidget {
  final double width;
  final double height;
  final String header_img;
  final String title;
  final String duration;
  final int lesson;

  const CardComponent(
      {Key key,
      this.width,
      this.height,
      this.header_img,
      this.title,
      this.duration,
      this.lesson})
      : super(key: key);

  @override
  _CardComponentState createState() => _CardComponentState();
}

class _CardComponentState extends State<CardComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        elevation: 2,
        child: Container(
          width: widget.width,
          height: widget.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: widget.width,
                height: widget.height - 50,
                padding: EdgeInsets.only(
                  left: 10,
                  bottom: 10,
                  right: 10,
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.header_img),
                  ),
                ),
              ),
              Container(
                transform: Matrix4.translationValues(0.0, -10, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        widget.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      child: Center(
                        child: Text(
                            "${widget.duration} | ${widget.lesson} Lessons"),
                      ),
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
}