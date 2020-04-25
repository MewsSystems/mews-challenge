import 'package:dfunc/dfunc.dart';

part 'results_event.g.dart';

@sealed
abstract class ResultsEvent with _$ResultsEvent {}

class ResultsInitialized extends ResultsEvent {
  ResultsInitialized(this.eventId);

  final String eventId;
}
