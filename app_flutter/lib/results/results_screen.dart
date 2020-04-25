import 'package:app_flutter/results/results_bloc.dart';
import 'package:app_flutter/results/results_state.dart';
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
              Padding(
                padding: const EdgeInsets.only(bottom: 105),
                child: Row(
                  children: <Widget>[
                    const _Logo(),
                    Text('Leaderboard', style: _headerStyle),
                  ],
                ),
              ),
              BlocBuilder<ResultsBloc, ResultsState>(
                builder: (context, state) => state.match(
                  (_) => Container(),
                  (data) => Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: data.data.map(_buildData).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _buildData(ResultsData data) => Expanded(
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
          children: mapIndexed(_buildResult, snapshot.data).toList(),
        ),
      );

  Widget _buildResult(int position, Result result) {
    final textStyle = _resultStyle.copyWith(fontSize: _textSize(position + 1));
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              '${_formatPosition(position + 1)} ${result.name}',
              style: textStyle,
            ),
          ),
          Expanded(
            child: Text(
              '${result.rightAnswerCount}/${result.questionCount} '
              '${formatTime(result.end.difference(result.start))}',
              style: textStyle,
            ),
          ),
        ],
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(right: 32),
        child: Image.asset(
          'assets/logo_big.png',
          width: 56,
          height: 75,
        ),
      );
}

String _formatPosition(int position) {
  if (position == 1) return '🥇';
  if (position == 2) return '🥈';
  if (position == 3) return '🥉';
  return '$position.';
}

double _textSize(int position) {
  if (position == 1) return 48;
  if (position <= 3) return 36;
  return 24;
}

const _titleStyle = TextStyle(
  fontSize: 36,
  fontWeight: FontWeight.w500,
);

const _headerStyle = TextStyle(
  height: 1.2,
  fontSize: 48,
  fontWeight: FontWeight.w500,
);

const _resultStyle = TextStyle(fontWeight: FontWeight.w500);
