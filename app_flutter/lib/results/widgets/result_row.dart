import 'package:core/core.dart';
import 'package:flutter/widgets.dart';

class ResultRow extends StatelessWidget {
  const ResultRow({
    Key key,
    @required this.position,
    @required this.result,
  }) : super(key: key);

  final int position;
  final Result result;

  @override
  Widget build(BuildContext context) {
    final textStyle = _resultStyle.copyWith(fontSize: _textSize(position));
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              '${_formatPosition(position)} ${result.name}',
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

const _resultStyle = TextStyle(fontWeight: FontWeight.w500);
