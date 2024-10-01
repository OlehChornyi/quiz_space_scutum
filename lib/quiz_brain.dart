import 'question.dart';

class QuizBrain {
  int _questionNumber = 0;
  final List<Question> _questionBank = [
    Question(q: 'Space Scutum company breeds cats.', a: false),
    Question(q: 'Space Scutum make a delicious ice cream.', a: false),
    Question(
        q: 'Space Scutum application is designed to give maximum protection to all users.',
        a: true),
    Question(
        q: 'Space Scutum care about the protection of users data.', a: true),
    Question(q: 'Space Scutum has 60-day money back guarantee.', a: false),
    Question(
        q: 'Space Scutum app built for everybody with unlimited unique features',
        a: true),
  ];

  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }

  String getQuestionText() {
    return _questionBank[_questionNumber].questionText;
  }

  int getQuestionLength() {
    return _questionBank.length;
  }

  bool getCorrectAnswer() {
    return _questionBank[_questionNumber].questionAnswer;
  }

  bool isFinished() {
    if (_questionNumber >= _questionBank.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  void reset() {
    _questionNumber = 0;
  }
}
