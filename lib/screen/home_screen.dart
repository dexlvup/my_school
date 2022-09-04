import 'package:flutter/material.dart';
import 'package:my_school/connect.dart';
import 'package:my_school/screen/news_detail_screen.dart';
import 'package:mysql1/mysql1.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _newsList = [];

  Future<void> _getNewsList() async {
    var connect = await MySqlConnection.connect(mysqlSettings);
    var results = await connect.query("""
        SELECT *, category.name c_name, users.name u_name  FROM news
        INNER JOIN users ON users.user_id = news.user_id
        INNER JOIN category ON news.category_id = category.category_id
        ORDER BY news.news_id desc
      """);

    print(results);

    for (var item in results) {
      _newsList.add({
        "news_id": item.fields['news_id'],
        "category_id": item.fields['category_id'],
        "thumbnail": item.fields['thumbnail'],
        "title": item.fields['title'],
        "content": item.fields['content'],
        "user_id": item.fields['user_id'],
        "c_name": item.fields['c_name'],
        "u_name": item.fields['u_name'],
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getNewsList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 250,
            child: Image.network(
              'https://media.npr.org/assets/img/2021/08/11/gettyimages-1279899488_wide-f3860ceb0ef19643c335cb34df3fa1de166e2761-s1100-c50.jpg',
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _newsList.length,
              itemBuilder: ((context, index) {
                return Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => NewsDetailScreen(
                            news_id: _newsList[index]['news_id'],
                          ),
                        ),
                      );
                    },
                    leading: Image.network(_newsList[index]['thumbnail']),
                    title: Text(_newsList[index]['title']),
                    subtitle: Text(_newsList[index]['c_name']),
                  ),
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}
