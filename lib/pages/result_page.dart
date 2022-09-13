import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_app/utils/constants.dart';

class ResultPage extends StatelessWidget {
  final int correctAnswer;

  ResultPage(this.correctAnswer);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return SafeArea(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            _btnColse(context),
            _resultContainer(context),
          ],
        ),
      ),
    );
  }

  Widget _resultContainer(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2 + 30,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
        color: Constants.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(15),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/images/trophy.png',
              height: 150,
              width: 150,
            ),
            Text(
              'Congrats!',
              style: TextStyle(
                color: Constants.purple,
                fontSize: 22,
                fontFamily: 'PB',
              ),
            ),
            Text(
              '${((correctAnswer * 100) / 20).toStringAsFixed(0)}% Score',
              style: TextStyle(
                color: Constants.green,
                fontSize: 35,
                fontFamily: 'PB',
              ),
            ),
            Text(
              'Quiz completed successfully',
              style: TextStyle(
                color: Constants.purple,
                fontSize: 18,
                fontFamily: 'PB',
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'You attempt',
                  style: Theme.of(context).textTheme.headline2,
                ),
                Text(
                  ' 20 Questions',
                  style: TextStyle(color: Constants.blue, fontFamily: 'PB'),
                ),
                Text(
                  ' and',
                  style: Theme.of(context).textTheme.headline2,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'from that',
                  style: Theme.of(context).textTheme.headline2,
                ),
                Text(
                  ' $correctAnswer Answer',
                  style: TextStyle(color: Constants.green, fontFamily: 'PB'),
                ),
                Text(
                  ' is correct',
                  style: Theme.of(context).textTheme.headline2,
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Share with us :',
                  style: Theme.of(context).textTheme.headline2,
                ),
                SizedBox(width: 15),
                FaIcon(
                  FontAwesomeIcons.instagram,
                  color: Constants.purple,
                ),
                SizedBox(width: 5),
                FaIcon(
                  FontAwesomeIcons.facebook,
                  color: Constants.purple,
                ),
                SizedBox(width: 5),
                FaIcon(
                  FontAwesomeIcons.whatsapp,
                  color: Constants.purple,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _btnColse(BuildContext context) {
    return Positioned(
      top: 20,
      right: 10,
      child: Container(
        child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.close,
            color: Colors.white,
          ),
          splashRadius: 20,
        ),
      ),
    );
  }
}
