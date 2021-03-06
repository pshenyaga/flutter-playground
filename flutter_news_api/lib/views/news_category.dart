import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_news_api/helpers/widgets.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_news_api/models/article.dart';
import 'package:flutter_news_api/secret.dart';

class NewsCategory extends StatefulWidget {
  @override
  _NewsCategoryState createState() => _NewsCategoryState();
}

class _NewsCategoryState extends State<NewsCategory> {
  Future<List<Article>> futureArticles;

  @override
  void initState() {
    super.initState();
    futureArticles = fetchArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(),
      drawer: myDrawer(context: context),
      body: SafeArea(
        child: Center(
            child: FutureBuilder<List<Article>>(
          future: futureArticles,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return NewsTile(
                    title: snapshot.data[index].title,
                    urlToImage: snapshot.data[index].urlToImage,
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else {
              return CircularProgressIndicator();
            }
          },
        )),
      ),
    );
  }
}

Future<List<Article>> fetchArticles() async {
  List<Article> result;
  final response = await http
      .get("https://newsapi.org/v2/everything?apiKey=$apiKey&q=bitcoin");

  final jsonData = jsonDecode(response.body);

  if (response.statusCode == 200) {
    result =
        (jsonData['articles'] as List).map((e) => Article.fromJson(e)).toList();
    return result;
  } else {
    throw Exception('Failed to load news');
  }
}

class NewsTile extends StatelessWidget {
  final String title;
  final String urlToImage;

  NewsTile({this.title, this.urlToImage});

  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 24),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (urlToImage != null)
            Image.network(
              urlToImage,
              width: MediaQuery.of(context).size.width,
              height: 200,
              fit: BoxFit.cover,
            ),
          SizedBox(height: 8),
          Container(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
