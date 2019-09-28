import 'package:app_flutter/games/game_timer.dart';
import 'package:app_flutter/games/question_widget.dart';
import 'package:core/core.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class CurrentGameScreen extends StatelessWidget {
  final GameInProgress game;

  const CurrentGameScreen({
    Key key,
    @required this.game,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthService authService = Provider.of(context);
    final GameService gameService = Provider.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            QuestionLabel(
              game: game,
              userId: authService.currentUser.uid,
            ),
            Spacer(),
            GameTimer(start: game.start),
          ],
        ),
        Container(height: 12),
        StreamBuilder<Question>(
            stream: gameService.getCurrentQuestion(
              authService.currentUser.uid,
              game.id,
            ),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: Text('Loading...'));
              }
              return QuestionWidget(
                question: snapshot.data,
                onAnswer: (answerId) {
                  _onAnswer(context, snapshot.data.id, answerId);
                },
              );
            }),
      ],
    );
  }

  void _onAnswer(BuildContext context, String questionId, String answerId) {
    final AuthService authService = Provider.of(context);
    Provider.of<GameService>(context).answerQuestion(
      authService.currentUser.uid,
      game.id,
      questionId,
      answerId,
    );
  }
}

class QuestionLabel extends StatelessWidget {
  const QuestionLabel({
    Key key,
    @required this.game,
    @required this.userId,
  }) : super(key: key);

  final GameInProgress game;
  final String userId;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Question>(
      stream:
          Provider.of<GameService>(context).getCurrentQuestion(userId, game.id),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Container();
        return Text(
          'Question ${snapshot.data.position}/${game.questionCount}',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF6B7989),
          ),
        );
      },
    );
  }
}
