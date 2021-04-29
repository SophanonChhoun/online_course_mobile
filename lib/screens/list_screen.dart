import 'package:flutter/material.dart';
import 'package:online_tutorial/components/card_component.dart';
import 'package:online_tutorial/models/category.dart';
import 'package:online_tutorial/models/course.dart';
import 'package:online_tutorial/repos/category_repos.dart';
import 'package:online_tutorial/repos/course_repos.dart';
import 'package:online_tutorial/screens/coursedetail.dart';
import 'package:online_tutorial/screens/search_screen.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  Future<CategoryData> _data;
  List<Category> _categories;
  Course _courses;
  CategoryRepo categoryRepo = new CategoryRepo();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _data = categoryRepo.readDataCategory();
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
          _data = categoryRepo.readDataCategory();
        });
      },
      child: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: EdgeInsets.all(8),
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
          _categories = snapshot.data.data;
          return _buildCategory();
        } else {
          return buildWaitCategory();
        }
      },
    );
  }

  buildWaitCategory() {
    var size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(5, (index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Flare Course",
              style: Theme.of(context).textTheme.headline1,
            ),
            SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(5, (indexs) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        buildWaitCourse(),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
            SizedBox(
              height: 10,
            )
          ],
        );
      }),
    );
  }

  buildWaitCourse() {
    var size = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: (size.width / 2) - 40,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
        ),
      ),
    );
  }

  _buildCategory() {
    var size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(_categories.length, (index) {
        if (_categories[index].courses.length > 0) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${_categories[index].courses.length > 0 ? _categories[index].name : ""}",
                style: Theme.of(context).textTheme.headline1,
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
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => CourseDetailScreen(
                                    id: _courses.id,
                                  ),
                                ),
                              );
                            },
                            child: CardComponent(
                              header_img: _courses.headerImg,
                              width: (size.width / 2) - 40,
                              height: 200,
                              title: _courses.title,
                              lesson: _courses.numberOfLessons,
                              duration: _courses.duration,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
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
