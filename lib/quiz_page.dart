import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quizzler/history_screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'quiz_brain.dart';

QuizBrain quizBrain = QuizBrain();

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];
  int numCorrectAnswers = 0;
  List<int> quizHistory = [];
  String _fullText = quizBrain.getQuestionText();
  String _displayedText = "";
  Timer? _timer;
  int _index = 0;

  @override
  void initState() {
    _startTyping();
    super.initState();
  }

  void _startTyping() {
    _timer?.cancel();

    _index = 0;
    _displayedText = "";

    _timer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      if (_index < _fullText.length) {
        setState(() {
          _displayedText += _fullText[_index];
          _index++;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getCorrectAnswer();

    setState(() {
      if (quizBrain.isFinished() == true) {
        quizHistory.add(numCorrectAnswers);
        Alert(
          closeFunction: (){
            _startTyping();
          },
          closeIcon: IconButton(onPressed: () {
            Navigator.pop(context);
            _startTyping();
          }, icon: Icon(Icons.close)),
          context: context,
          
          title: 'Quiz Finished!',
          desc:
              'You\'ve finished the quize. Your results: $numCorrectAnswers correct answers out of ${quizBrain.getQuestionLength()}.',
        ).show();
        quizBrain.reset();
        scoreKeeper = [];
        numCorrectAnswers = 0;
      } else {
        if (userPickedAnswer == correctAnswer) {
          numCorrectAnswers++;
          scoreKeeper.add(
            const Icon(
              Icons.check,
              color: Colors.green,
            ),
          );
        } else {
          scoreKeeper.add(
            const Icon(
              Icons.close,
              color: Colors.red,
            ),
          );
        }
        quizBrain.nextQuestion();
        _fullText = quizBrain.getQuestionText();
        _startTyping();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => HistoryPage(quizHistory: quizHistory),
              ),
            );
          },
          child: Container(
            color: Colors.white,
            height: 20,
            width: 20,
            child: const Text(
              'See Results History',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                _displayedText,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              // child: Text(
              //   quizBrain.getQuestionText(),
              //   textAlign: TextAlign.center,
              //   style: const TextStyle(
              //     fontSize: 25.0,
              //     color: Colors.white,
              //   ),
              // ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                textStyle: const TextStyle(
                  fontSize: 30.0,
                  color: Colors.white,
                ),
              ),
              child: const Text(
                'True',
              ),
              onPressed: () {
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                textStyle: const TextStyle(
                  fontSize: 30.0,
                  color: Colors.white,
                ),
              ),
              child: const Text('False'),
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }
}
