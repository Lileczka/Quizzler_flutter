

import 'question.dart';

class General {

  int _questionNumber = 0;
   bool _finished = false;
  
  List<Question> _questionTotal = [
    Question('Les 3 couleurs du drapeau italien sont Vert, Blanc et Rouge? ', true),
    Question('Dans une célèbre fable de Jean de La Fontaine la tortue dit : "Vous êtes le Phénix des hôtes de ces bois" ?', false),
    Question('Le bitcoin est une première monnaie numérique créée en 2009 ?', true),
    Question('Les années bissextiles ont 366 jours?', true),
    Question('Nail Amstrong a été le premier homme à marcher sur la Lune ?', true),
    Question('L’hexagone est le surnom donné à la France?', true),
    Question('Le système solaire compte 12 planètes?',false),
    Question('La langue officielle du Brésil est le portugais?',true),
    Question('Pour obtenir du violet il faut mélanger blanc et noir?',false),
    Question('The total surface area of two human lungs is approximately 70 square metres.',
        true),
    Question('Le talon est le point faible d\'Achille? ', true),
    Question('TicToc est le site internet  le plus visité dans le monde en 2021 ?',true),
    Question('Le pouce est est une unité de mesure américaine ?', true)];

  void nextQuestion(){
    if(_questionNumber < _questionTotal.length - 1) {
      _questionNumber++;
    } else {
    _finished = true; // Marquer les questions comme étant terminées
  }
   }

  String getQuestionText(){
    return _questionTotal[_questionNumber].question;
  }

  bool getCorrectAnswer(){
    return _questionTotal[_questionNumber].answer;
  }

// Méthode pour vérifier si toutes les questions ont été répondues
  bool isFinished() {
    return _finished;
  }
  void reset() {
    _questionNumber = 0;
  }
  
}
