import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quiz_app/models/question.dart';
import 'package:quiz_app/pages/result_page.dart';
import 'package:quiz_app/utils/constants.dart';

class QuestionPage extends StatefulWidget {
  final String appBarTitle;
  final String appBarIcon;
  final String difficulty;

  QuestionPage(this.appBarTitle, this.appBarIcon, this.difficulty);
  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  List<bool> selected = [
    false,
    false,
    false,
    false,
  ];
  List<String> items = [
    'A',
    'B',
    'C',
    'D',
  ];
  int currentQuestion = 0;
  late Future<List<Question>> futureQuestionList;
  List<String> answers = [];
  String choosenAnswer = '';
  int correctAnswer = 0;
  String nextBtn = 'Next';
  List<Question>? questionList;

  @override
  void initState() {
    super.initState();
    //for call api and get data as Future
    futureQuestionList = getQeustions();
  }

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
      elevation: 0,
      toolbarHeight: 80,
      title: Text(widget.appBarTitle),
      leading: Padding(
        padding: EdgeInsets.all(8),
        child: Image.asset(
          'assets/icons/${widget.appBarIcon}.png',
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
    return SafeArea(
      //use FutureBuilde for show data after get it
      child: FutureBuilder(
        future: futureQuestionList,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            //get raw data
            questionList = snapshot.data;
            return OrientationBuilder(
              builder: (context, orientation) {
                if (orientation == Orientation.portrait) {
                  return _portraitMode(questionList![currentQuestion]);
                } else {
                  return _landscapeMode(questionList![currentQuestion]);
                }
              },
            );
          } else {
            return Center(
              child: SpinKitFadingCircle(
                color: Constants.white,
                size: 60,
              ),
            );
          }
        },
      ),
    );
  }

  Widget _landscapeMode(Question question) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 40),
          sliver: SliverToBoxAdapter(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Difficulty : ${widget.difficulty}',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    Text('${currentQuestion + 1} of 20',
                        style: Theme.of(context).textTheme.headline1),
                  ],
                ),
                Divider(
                  thickness: 2,
                  color: Constants.white,
                ),
                SizedBox(height: 20),
                Text(
                  question.question,
                  style: Theme.of(context).textTheme.headline1,
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 20),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 4,
              (context, index) => _listTile(index, answers[index]),
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          sliver: SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      currentQuestion == 0
                          ? currentQuestion = 0
                          : currentQuestion--;

                      correctAnswer != 0 ? correctAnswer-- : correctAnswer = 0;

                      //get pre question's answer
                      getAnswers(questionList!);

                      for (var i = 0; i < 4; i++) {
                        selected[i] = false;
                      }
                    });
                  },
                  child: Text('Pre'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (currentQuestion == 19) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResultPage(correctAnswer),
                          ),
                        );
                      } else {
                        currentQuestion++;
                      }

                      choosenAnswer == question.correctAnswer
                          ? correctAnswer++
                          : correctAnswer + 0;

                      //get other question's answer
                      getAnswers(questionList!);

                      choosenAnswer = '';

                      for (var i = 0; i < 4; i++) {
                        selected[i] = false;
                      }
                    });
                  },
                  child: Text(currentQuestion == 19 ? 'Finish' : 'Next'),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _portraitMode(Question question) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        children: [
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Difficulty : ${widget.difficulty}',
                style: Theme.of(context).textTheme.headline1,
              ),
              Text('${currentQuestion + 1} of 20',
                  style: Theme.of(context).textTheme.headline1),
            ],
          ),
          Divider(
            thickness: 2,
            color: Constants.white,
          ),
          SizedBox(height: 20),
          Text(
            question.question,
            style: Theme.of(context).textTheme.headline1,
          ),
          Spacer(),
          ...List.generate(4, (index) => _listTile(index, answers[index])),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    //show previous question
                    currentQuestion == 0
                        ? currentQuestion = 0
                        : currentQuestion--;

                    //update correct answer -1 if user go back pre question
                    correctAnswer != 0 ? correctAnswer-- : correctAnswer = 0;

                    //get pre question's answer
                    getAnswers(questionList!);

                    //reset choosen TileList
                    for (var i = 0; i < 4; i++) {
                      selected[i] = false;
                    }
                  });
                },
                child: Text('Pre'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    //for last question change next btn to finish and go to next page.
                    if (currentQuestion == 19) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultPage(correctAnswer),
                        ),
                      );
                    } else {
                      currentQuestion++;
                    }
                    //update correct answer +1
                    choosenAnswer == question.correctAnswer
                        ? correctAnswer++
                        : correctAnswer + 0;

                    //get other question's answer
                    getAnswers(questionList!);

                    //reset choosen answer
                    choosenAnswer = '';

                    //reset choosen TileList
                    for (var i = 0; i < 4; i++) {
                      selected[i] = false;
                    }
                  });
                },
                child: Text(currentQuestion == 19 ? 'Finish' : 'Next'),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _listTile(int i, String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Material(
        borderRadius: BorderRadius.circular(100),
        color: Colors.transparent,
        elevation: 8,
        child: ListTile(
          onTap: () {
            setState(() {
              //update selected ListTile
              for (var i = 0; i < 4; i++) {
                selected[i] = false;
              }
              selected[i] = true;

              //save choosen answer
              choosenAnswer = title;
            });
          },
          selected: selected[i],
          title: Text(
            title,
            style: TextStyle(
              fontFamily: 'DP',
              fontSize: 20,
            ),
          ),
          leading: Material(
            shape: CircleBorder(),
            elevation: 5,
            child: Container(
              alignment: Alignment.center,
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                color: Constants.orange,
                shape: BoxShape.circle,
              ),
              child: Text(
                items[i],
                style: TextStyle(
                  color: Constants.white,
                  fontSize: 30,
                  fontFamily: 'DP',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<List<Question>> getQeustions() async {
    //call api with dio and give it parametrs
    Response response = await Dio().get(
      Constants.baseUrl,
      queryParameters: {
        'categories': widget.appBarTitle.toLowerCase().replaceAll(' ', '_'),
        'limit': 20,
        'difficulty': widget.difficulty.toLowerCase(),
      },
    );

    //save data in list
    List<Question> questionLists =
        response.data.map<Question>((e) => Question.fromMapJson(e)).toList();

    //get first question's answers
    getAnswers(questionLists);

    return questionLists;
  }

  void getAnswers(List<Question> questionList) {
    answers = [
      questionList[currentQuestion].incorrectAnswers[0],
      questionList[currentQuestion].incorrectAnswers[1],
      questionList[currentQuestion].incorrectAnswers[2],
      questionList[currentQuestion].correctAnswer
    ];
    //shuffle answers
    answers.shuffle();
  }
}
