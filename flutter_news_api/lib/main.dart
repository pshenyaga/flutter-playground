import 'package:flutter/material.dart';
import 'package:flutter_news_api/views/homepage.dart';

void main() => runApp(NewsAPI());

class NewsAPI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter News API',
      home: HomePage(),
    );
  }
}
