import 'package:flutter/material.dart';

import 'package:flutter_news_api/helpers/widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(),
      drawer: myDrawer(context: context),
    );
  }
}
