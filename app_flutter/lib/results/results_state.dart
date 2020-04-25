import 'package:core/core.dart';
import 'package:dfunc/dfunc.dart';

part 'results_state.g.dart';

@sealed
abstract class ResultsState with _$ResultsState {}

class ResultsLoading extends ResultsState {}

class ResultsLoaded extends ResultsState {
  ResultsLoaded(this.data);

  final List<ResultsData> data;
}

class ResultsData {
  ResultsData({this.game, this.results});

  final GameInfo game;
  final Stream<List<Result>> results;
}
