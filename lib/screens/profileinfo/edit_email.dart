import 'package:flutter/material.dart';

class EmailEdit extends StatefulWidget {
  @override
  _EmailEditState createState() => _EmailEditState();
}

class _EmailEditState extends State<EmailEdit> {
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
        title: const Text(
          'Edit Email',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: _buildBody(context),
    );
  }
}

_buildBody(BuildContext context) {
  return Center(
    child: Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Your Email',
              ),
            ),
            SizedBox(
              height: 80,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    "Update",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
