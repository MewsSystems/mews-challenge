import 'package:app_flutter/results/results_bloc.dart';
import 'package:app_flutter/results/results_state.dart';
import 'package:app_flutter/results/widgets/header.dart';
import 'package:app_flutter/results/widgets/result_row.dart';
import 'package:core/core.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({Key key, @required this.eventId}) : super(key: key);

  final String eventId;

  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ResultsBloc>(context).onInitialized(widget.eventId);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(72),
          child: Column(
            children: <Widget>[
              const Header(),
              BlocBuilder<ResultsBloc, ResultsState>(
                builder: (_, state) => state.match(
                  (_) => Container(),
                  (data) => _buildResultsLoaded(data),
                ),
              ),
            ],
          ),
        ),
      );

  Row _buildResultsLoaded(ResultsLoaded data) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: data.data.map(_buildResultsData).toList(),
      );

  Widget _buildResultsData(ResultsData data) => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(data.game.title, style: _titleStyle),
            Container(height: 60),
            _buildResults(data.results),
          ],
        ),
      );

  Widget _buildResults(Stream<List<Result>> results) =>
      StreamBuilder<List<Result>>(
        stream: results,
        initialData: [],
        builder: (context, snapshot) => Column(
          children: mapIndexed(
            (i, result) => ResultRow(position: i + 1, result: result),
            snapshot.data,
          ).toList(),
        ),
      );
}

const _titleStyle = TextStyle(
  fontSize: 36,
  fontWeight: FontWeight.w500,
);
