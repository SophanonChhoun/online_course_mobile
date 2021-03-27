import 'package:flutter/material.dart';
import 'package:online_tutorial/models/author.dart';

class RowComponent extends StatefulWidget {
  final String header_img;
  final String title;
  final Author author;
  final String duration;
  final int lesson;

  const RowComponent(
      {Key key,
      this.header_img,
      this.title,
      this.author,
      this.duration,
      this.lesson})
      : super(key: key);

  @override
  _RowComponentState createState() => _RowComponentState();
}

class _RowComponentState extends State<RowComponent> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                widget.header_img,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          width: 16,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.title,
              style: Theme.of(context).textTheme.headline1,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "${widget.author.firstName} ${widget.author.lastName}",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "${widget.duration} | ${widget.lesson} Lessons",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ],
    );
  }
}
