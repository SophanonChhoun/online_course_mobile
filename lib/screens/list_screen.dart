import 'package:flutter/material.dart';
import 'package:online_tutorial/components/card_component.dart';
import 'package:online_tutorial/models/category.dart';
import 'package:online_tutorial/models/course.dart';
import 'package:online_tutorial/repos/category_repos.dart';
import 'package:online_tutorial/screens/search_screen.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  Future<CategoryData> _data;
  List<Category> _categories;
  Course _courses;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _data = readDataCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody,
      backgroundColor: Colors.blueGrey.shade50,
    );
  }

  get _buildBody {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          _data = readDataCategory();
        });
      },
      child: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: EdgeInsets.all(8),
            color: Colors.blueGrey.shade50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.search,
                          size: 30,
                        ),
                        onPressed: () {
                          showSearch(context: context, delegate: DataSearch());
                        }),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: 16,
                  ),
                  child: _buildView(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildView() {
    return FutureBuilder<CategoryData>(
      future: _data,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print("snapshot.error: ${snapshot.error}");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          // print(snapshot.data.success);
          // print(snapshot.data.data[0].title);

          _categories = snapshot.data.data;
          print(_categories[0].name);
          return _buildCategory();
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  _buildCategory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(_categories.length, (index) {
        if (_categories[index].courses.length > 0) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${_categories[index].courses.length > 0 ? _categories[index].name : ""}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 33,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(_categories[index].courses.length,
                      (indexs) {
                    _courses = _categories[index].courses[indexs];
                    return Row(
                      children: [
                        CardComponent(
                          header_img: _courses.headerImg,
                          width: 170,
                          height: 240,
                          title: _courses.title,
                          lesson: _courses.numberOfLessons,
                          duration: _courses.duration,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    );
                  }),
                ),
              ),
              SizedBox(
                height: 10,
              )
            ],
          );
        }
        return Container();
      }),
    );
  }
}
