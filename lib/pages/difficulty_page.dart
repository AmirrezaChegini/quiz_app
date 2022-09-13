import 'package:flutter/material.dart';
import 'package:quiz_app/pages/question_page.dart';
import 'package:quiz_app/utils/constants.dart';

class DifficultyPage extends StatelessWidget {
  final String appBarTitle;
  final String appBarIcon;

  DifficultyPage(this.appBarTitle, this.appBarIcon);

  final List<String> listDifficulty = [
    'Easy',
    'Medium',
    'Hard',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _body(),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 80,
      title: Text(appBarTitle),
      leading: Padding(
        padding: EdgeInsets.all(8),
        child: Image.asset(
          'assets/icons/$appBarIcon.png',
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close),
          splashRadius: 20,
        ),
      ],
    );
  }

  Widget _body() {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.all(10),
          sliver: SliverToBoxAdapter(
            child: _image(appBarIcon),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: 3,
            (context, index) => _listTile(context, listDifficulty[index]),
          ),
        ),
      ],
    );
  }

  Widget _listTile(BuildContext context, String difficulty) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(8),
        color: Colors.transparent,
        child: ListTile(
          onTap: () => goToQuestionPage(context, difficulty),
          tileColor: Constants.purpleLight,
          contentPadding: EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          title: Text(
            difficulty,
            textAlign: TextAlign.center,
            style: TextStyle(color: Constants.white, fontSize: 30),
          ),
        ),
      ),
    );
  }

  Widget _image(String icon) {
    switch (icon) {
      case 'icon_art':
        return Image.asset('assets/images/back_art.png');
      case 'icon_fim':
        return Image.asset('assets/images/back_film.png');
      case 'icon_food':
        return Image.asset('assets/images/back_food.png');
      case 'icon_genknowledge':
        return Image.asset('assets/images/back_genknoledge.png');
      case 'icon_geo':
        return Image.asset('assets/images/back_geo.png');
      case 'icon_music':
        return Image.asset('assets/images/back_music.png');
      case 'icon_sport':
        return Image.asset('assets/images/back_sport.png');
      default:
        return Image.asset('assets/images/back_art.png');
    }
  }

  void goToQuestionPage(BuildContext context, String difficulty) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => QuestionPage(appBarTitle, appBarIcon, difficulty),
      ),
    );
  }
}
