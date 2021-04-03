import 'package:flutter/material.dart';
import 'package:online_tutorial/components/card_component.dart';
import 'package:online_tutorial/models/category.dart';
import 'package:online_tutorial/models/course.dart';
import 'package:online_tutorial/repos/category_repos.dart';
import 'package:online_tutorial/screens/coursedetail.dart';

class UserCourse extends StatefulWidget {
  @override
  _UserCourseState createState() => _UserCourseState();
}

class _UserCourseState extends State<UserCourse> {
  Future<CategoryData> _data;
  List<Category> _categories;
  Course _courses;
  CategoryRepo categoryRepo = new CategoryRepo();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _data = categoryRepo.readDataUserCategory();
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
          _data = categoryRepo.readDataUserCategory();
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
