import 'package:flutter/material.dart';
import 'package:quiz_app/pages/difficulty_page.dart';
import 'package:quiz_app/utils/constants.dart';

class HomePage extends StatelessWidget {
  final List<String> listTitle = [
    'Arts and Literature',
    'Film and TV',
    'Food and Drink',
    'General Knowledge',
    'Geography',
    'Music',
    'Sport and Leisure',
  ];

  final List<String> listIcon = [
    'icon_art',
    'icon_fim',
    'icon_food',
    'icon_genknowledge',
    'icon_geo',
    'icon_music',
    'icon_sport',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      toolbarHeight: 100,
      elevation: 8,
      title: Text(
        'Quiz App',
        style: TextStyle(
          color: Constants.white,
          fontSize: 34,
          shadows: [
            Shadow(
              color: Constants.black,
              blurRadius: 15,
            )
          ],
        ),
      ),
      centerTitle: true,
      leading: Icon(
        Icons.menu,
        size: 35,
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 15),
          child: Material(
            elevation: 8,
            shape: CircleBorder(),
            child: Image.asset(
              'assets/images/account.png',
              width: 50,
              height: 50,
            ),
          ),
        ),
      ],
    );
  }

  Widget _body() {
    return ListView.builder(
      itemCount: listTitle.length,
      padding: EdgeInsets.only(top: 16),
      itemBuilder: (context, index) =>
          _listTile(context, listTitle[index], listIcon[index]),
    );
  }

  Widget _listTile(BuildContext context, String title, String icon) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(8),
        color: Colors.transparent,
        child: ListTile(
          onTap: () => goToDifficultyPage(context, title, icon),
          tileColor: Constants.purpleLight,
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          leading: Image.asset(
            'assets/icons/$icon.png',
            width: 50,
            height: 50,
          ),
          title: Text(
            title,
            style: TextStyle(color: Constants.white, fontSize: 20),
          ),
        ),
      ),
    );
  }

  void goToDifficultyPage(
      BuildContext context, String appBarTitle, String appBarIcon) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DifficultyPage(appBarTitle, appBarIcon),
      ),
    );
  }
}
