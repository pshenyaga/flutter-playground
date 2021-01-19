import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_news_api/models/article.dart';
import 'package:flutter_news_api/secret.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Article>> futureArticles;

  @override
  void initState() {
    super.initState();
    futureArticles = fetchArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: FutureBuilder<List<Article>>(
          future: futureArticles,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Text(snapshot.data[index].title),
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
