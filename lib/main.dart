import 'package:flutter/material.dart';
import 'general.dart';


void main() => runApp(Quizzler());

//QuizBrain quizBrain = QuizBrain();
General general = General();

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Widget> scoreKeeper = [];

  void check(bool userAnswer) {
    bool answer = general.getCorrectAnswer();
    setState(() {
      if (userAnswer == answer) {
        scoreKeeper.add(Icon(
          Icons.thumb_up_outlined,
          color: Colors.green,
        ));
      } else {
        scoreKeeper.add(Icon(
          Icons.thumb_down_outlined,
          color: Colors.red,
        ));
      }
      // Vérifier si toutes les questions ont été répondues
      if (general.isFinished()) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('C\'est fini'),
              content: Text('Vous avez répondu à toutes les questions.'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    setState(() {
                      // Réinitialiser les questions pour permettre de recommencer
                      general.reset();
                      scoreKeeper.clear();
                    });
                    Navigator.of(context).pop(); // Fermer la boîte de dialogue
                  },
                ),
              ],
            );
          },
        );
      } else {
        general.nextQuestion(); // Passer à la question suivante
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                general.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                check(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                check(false);
              },
            ),
          ),
        ),
        Expanded(
          child: Row(
            children: scoreKeeper,
          ),
        ),
      ],
    );
  }
}
