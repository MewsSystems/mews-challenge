import 'package:core/core.dart';
import 'package:flutter/widgets.dart';

class GameTimer extends StatelessWidget {
  const GameTimer({Key key, @required this.start}) : super(key: key);

  final DateTime start;

  @override
  Widget build(BuildContext context) => StreamBuilder<DateTime>(
        stream: Stream.periodic(Duration(seconds: 1), (_) => DateTime.now()),
        initialData: DateTime.now(),
        builder: (context, snapshot) {
          return Text(
            formatTime(snapshot.data.difference(start)),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          );
        },
      );
}
