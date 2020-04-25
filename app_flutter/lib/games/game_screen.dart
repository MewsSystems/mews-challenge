import 'package:after_init/after_init.dart';
import 'package:app_flutter/auth/login_screen.dart';
import 'package:app_flutter/common/screen.dart';
import 'package:app_flutter/games/completed_game_screen.dart';
import 'package:app_flutter/games/current_game_screen.dart';
import 'package:core/core.dart';
import 'package:firebase/firebase.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatefulWidget {
  final String gameId;

  const GameScreen({Key key, this.gameId}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>
    with AfterInitMixin<GameScreen> {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return StreamBuilder<User>(
      stream: authService.user,
      initialData: authService.currentUser,
      builder: (context, snapshot) {
        final screen =
            snapshot.hasData ? _buildGameWidget(context) : LoginScreen();
        return Screen(
          children: <Widget>[
            screen,
          ],
        );
      },
    );
  }

  Widget _buildGameWidget(BuildContext context) => StreamBuilder<GameState>(
        stream: Provider.of<GameService>(context).getGame(widget.gameId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: Text('Loading...'));
          return snapshot.data.join(
            (_) => Center(child: Text('Creating game...')),
            (game) => CurrentGameScreen(game: game),
            (game) => CompletedGameScreen(game: game),
          );
        },
      );

  @override
  void didInitState() {
    _startGame();
  }

  void _startGame() async {
    final user = await Provider.of<AuthService>(context)
        .user
        .where((u) => u != null)
        .first;
    await Provider.of<GameService>(context).startGame(user.uid, widget.gameId);
  }
}
