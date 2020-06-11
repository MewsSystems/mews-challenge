import 'package:app_flutter/games/result_widget.dart';
import 'package:core/core.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class CompletedGameScreen extends StatelessWidget {
  const CompletedGameScreen({
    Key key,
    @required this.game,
  }) : super(key: key);

  final GameCompleted game;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Image.asset('assets/congrats.png', height: 47, width: 47),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 32),
          child: Text(
            'Good job\n${getFirstName(authService.currentUser)}!',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Text(
            'You\'ve finished our test with score:',
            style: TextStyle(
              color: const Color(0xFF969FAB),
              fontSize: 16,
            ),
          ),
        ),
        Text(
          '${game.rightAnswerCount}/${game.questionCount}',
          style: TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.w600,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            'In time: ${formatTime(game.duration)}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
        ResultWidget(resultType: game.resultType),
      ],
    );
  }
}
