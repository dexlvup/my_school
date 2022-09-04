import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_school/connect.dart';
import 'package:mysql1/mysql1.dart';

class NewsDetailScreen extends StatefulWidget {
  final int news_id;
  const NewsDetailScreen({
    super.key,
    required this.news_id,
  });

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  var newsDetail = {};

  Future<void> _getNewsById() async {
    var connect = await MySqlConnection.connect(mysqlSettings);
    var result = await connect.query(
      """
        SELECT *, category.name c_name, users.name u_name  FROM news
        INNER JOIN users ON users.user_id = news.user_id
        INNER JOIN category ON news.category_id = category.category_id
        WHERE news.news_id = ?
      """,
      [widget.news_id],
    );
    setState(() {
      newsDetail = {
        "news_id": result.first.fields['news_id'],
        "title": result.first.fields['title'],
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          newsDetail['title'],
        ),
      ),
    );
  }
}
