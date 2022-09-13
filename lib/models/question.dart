class Question {
  String _question;
  String _correctAnswer;
  List<dynamic> _incorrectAnswers;

  Question(this._question, this._correctAnswer, this._incorrectAnswers);

  factory Question.fromMapJson(Map<String, dynamic> jsonObject) {
    return Question(
      jsonObject['question'],
      jsonObject['correctAnswer'],
      jsonObject['incorrectAnswers'],
    );
  }

  String get question => _question;
  String get correctAnswer => _correctAnswer;
  List<dynamic> get incorrectAnswers => _incorrectAnswers;
}
