import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:app_angular/src/common/code_formatter_pipe.dart';
import 'package:core/core.dart';
import 'package:firebase/firebase.dart';

class Image {
  Image(this.url, this.letter);

  final String url;
  final String letter;
}

@Component(
  selector: 'current-question',
  templateUrl: 'current_question_component.html',
  styleUrls: ['current_question_component.css'],
  pipes: [commonPipes, CodeFormatterPipe],
  directives: [NgIf, NgFor, MaterialButtonComponent],
)
class CurrentQuestionComponent implements AfterChanges {
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

  Map<String, Map<String, String>> imageUrls = {};

  Future<void> getImageUrls() async {
    try {
      final list = await Future.wait(question.answers
          .where((a) => a.image != null)
          .map((a) async => storage()
              .ref('questions/${a.image}')
              .getDownloadURL()
              .then((v) => MapEntry(a.id, v.toString()))));
      imageUrls[question.id] = Map.fromEntries(list);
    } on Error {
      // do nothing
    }
  }

  String get tagClass => question.tag == 'C#' ? 'CS' : question.tag;

  @override
  void ngAfterChanges() {
    getImageUrls();
  }
}
