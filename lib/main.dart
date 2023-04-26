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
        backgroundColor: Color.fromARGB(255, 65, 59, 246),
        appBar: AppBar(
          title: Text('Quizz'),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 1, 8, 66),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: QuizPage(),
              ),
              Container(
                height: 100.0,
                color: Color.fromARGB(255, 1, 8, 66),
              ),
            ],
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
          color: Color.fromARGB(255, 19, 225, 43),
        ));
      } else {
        scoreKeeper.add(Icon(
          Icons.thumb_down_outlined,
          color: Color.fromARGB(255, 250, 89, 89),
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
    return Container(
      color: Color.fromARGB(255, 59, 39, 187),
      child: Column(
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
                  backgroundColor: Color.fromARGB(255, 10, 167, 36),
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
      ),
    );
  }
}