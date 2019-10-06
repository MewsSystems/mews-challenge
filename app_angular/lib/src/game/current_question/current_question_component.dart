import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:app_angular/src/common/code_formatter_pipe.dart';
import 'package:app_angular/src/game/question/question_component.dart';
import 'package:core/core.dart';

class Image {
  Image(this.url, this.letter);

  final String url;
  final String letter;
}

@Component(
  selector: 'current-question',
  template:
      '<question [question]="question" [onAnswer]="answerQuestion"></question>',
  pipes: [commonPipes, CodeFormatterPipe],
  directives: [NgIf, NgFor, MaterialButtonComponent, QuestionComponent],
)
class CurrentQuestionComponent {
  CurrentQuestionComponent(this._gameService, this._authService);

  final GameService _gameService;
  final AuthService _authService;

  @Input()
  Question question;

  @Input()
  String gameId;

  Future<void> answerQuestion(String answerId) async {
    final userId = (await _authService.user.first).uid;
    final questionId = question.id;
    querySelector('html').scrollTop = 0;
    await _gameService.answerQuestion(userId, gameId, questionId, answerId);
  }
}
