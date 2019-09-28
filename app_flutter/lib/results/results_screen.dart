import 'package:app_flutter/simple_route.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ResultsScreen extends StatefulWidget {
  @override
  _ResultsScreenState createState() => _ResultsScreenState();

  static Route<dynamic> route() {
    return SimpleRoute(
      name: '/results',
      title: 'Results',
      builder: (_) => ResultsScreen(),
    );
  }
}

class _ResultsScreenState extends State<ResultsScreen> {
  final _resultsService = ResultsService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(72),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 105),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 32),
                    child: Image.asset(
                      'assets/logo_big.png',
                      width: 56,
                      height: 75,
                    ),
                  ),
                  Text('Leaderboard', style: _headerStyle),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '💻 Developer game',
                        style: _titleStyle,
                      ),
                      Container(height: 60),
                      _buildResults(_resultsService.developerResults),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '🖌 Design game',
                        style: _titleStyle,
                      ),
                      Container(height: 60),
                      _buildResults(_resultsService.designResults),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResults(Stream<List<Result>> results) =>
      StreamBuilder<List<Result>>(
        stream: results,
        initialData: [],
        builder: (context, snapshot) {
          return Column(
            children: snapshot.data
                .asMap()
                .map((i, r) => MapEntry(i, _buildResult(i, r)))
                .values
                .toList(),
          );
        },
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
