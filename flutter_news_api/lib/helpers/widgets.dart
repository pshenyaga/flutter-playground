import 'package:flutter/material.dart';
import 'package:flutter_news_api/views/news_category.dart';
import 'package:flutter_news_api/helpers/widgets.dart';

Widget myAppBar() {
  return AppBar(
    title: Text("NewsAPI"),
  );
}

Widget myDrawer({context}) {
  return Drawer(
    child: ListView(
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text(
            'Drawer header',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        ListTile(
          title: Text(
            'BitCoin',
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => NewsCategory()));
          },
        )
      ],
    ),
  );
}
