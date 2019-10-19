import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:app_angular/src/common/code_formatter_pipe.dart';
import 'package:core/core.dart';
import 'package:firebase/firebase.dart';

@Component(
  selector: 'question',
  directives: [NgIf, NgFor, MaterialButtonComponent, QuestionComponent],
  pipes: [CodeFormatterPipe, commonPipes],
  templateUrl: 'question_component.html',
  styleUrls: ['question_component.css'],
)
class QuestionComponent implements AfterChanges {
  @Input()
  Question question;

  @Input()
  Future<void> Function(String) onAnswer;

  String get tagClass => question.tag == 'C#' ? 'CS' : question.tag;

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

  void answerQuestion(String answerId) {
    onAnswer?.call(answerId);
  }

  @override
  void ngAfterChanges() {
    getImageUrls();
  }
}
