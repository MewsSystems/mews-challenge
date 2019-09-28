import 'package:angular/angular.dart';
import 'package:core/core.dart';

@Component(
  selector: 'results',
  styleUrls: ['results_component.css'],
  templateUrl: 'results_component.html',
  directives: [
    NgFor,
    NgIf,
  ],
  pipes: [AsyncPipe],
)
class ResultsComponent {
  ResultsComponent(this._service) {
    developerResults = _service.developerResults;
    designResults = _service.designResults;
  }

  final ResultsService _service;

  Stream<List<Result>> developerResults;
  Stream<List<Result>> designResults;
}
