import 'package:flutter/material.dart';
import 'package:online_tutorial/components/row_component.dart';
import 'package:online_tutorial/models/course.dart';
import 'package:online_tutorial/repos/category_repos.dart';
import 'package:online_tutorial/repos/course_repos.dart';

class DataSearch extends SearchDelegate<String> {
  final statelist = [
    'Andaman and Nicobar Islands',
    '   Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chandigarh ',
    'Chhattisgarh',
    'Dadra and Nagar Havel',
    'Daman and Diu',
    'Delhi',
    'Goa',
    'Gujrat',
    'Haryana',
    'Himachal Pradesh',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal',
    'Sikkim',
    'Meghalya',
    'Mizoram',
  ];
  final recentlist = ['Modingar', 'Ghaziabad', 'Merrut', 'Hapur', 'Delhi'];
  Future<CourseData> _data;
  Future<CourseData> _searchData;
  List<Course> _courseData;
  List<Course> _searchCourse;
  List<Course> _searchCourseData;

  DataSearch() {
    _data = readDataAllCourse();
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    // action for app bar
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // leading icon on the left of the app bar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    print(query);
    _searchData = readDataSearchCourse(query);
    // return Text("Hello");
    return _buildResultView();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    final suggestionList = query.isEmpty
        ? recentlist
        : statelist
            .where((element) =>
                element.toLowerCase().startsWith(query.toLowerCase()))
            .toList();
    return _buildView();
  }

  _buildView() {
    return FutureBuilder<CourseData>(
      future: _data,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print("snapshot.error: ${snapshot.error}");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          // print(snapshot.data.success);
          // print(snapshot.data.data[0].title);

          _courseData = snapshot.data.data;

          return _buildListView();
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  _buildListView() {
    final _searchCourse = query.isEmpty
        ? _courseData
        : _courseData
            .where((element) => element.title.startsWith(query))
            .toList();
    final courseLength = query.isEmpty ? 5 : _searchCourse.length;
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          print("Hello");
        },
        title: RichText(
          text: TextSpan(
              text: _searchCourse[index].title.substring(0, query.length),
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                    text: _searchCourse[index].title.substring(query.length),
                    style: TextStyle(color: Colors.grey))
              ]),
        ),
      ),
      itemCount: courseLength,
    );
  }

  _buildResultView() {
    return FutureBuilder<CourseData>(
      future: _searchData,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print("snapshot.error: ${snapshot.error}");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          // print(snapshot.data.success);
          // print(snapshot.data.data[0].title);

          _searchCourse = snapshot.data.data;

          return _buildItemResult();
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  _buildItemResult() {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(top: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(_searchCourse.length, (index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    print(_searchCourse[index].title);
                  },
                  child: RowComponent(
                    header_img: _searchCourse[index].headerImg,
                    title: _searchCourse[index].title,
                    author: _searchCourse[index].author,
                    lesson: _searchCourse[index].numberOfLessons,
                    duration: _searchCourse[index].duration,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
