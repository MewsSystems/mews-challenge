import 'package:firebase/firebase.dart';
import 'package:firebase/firestore.dart';
import 'package:rxdart/rxdart.dart';

import '../auth_service.dart';
import 'game.dart';
import 'question.dart';

class GameService {
  GameService(this._authService);

  final AuthService _authService;

  Stream<List<GameState>> getGames() =>
      Observable(_authService.user.map((u) => u?.uid)).switchMap((userId) {
        final Stream<Iterable<GameState>> userGames = userId == null
            ? Observable.just(<GameState>[])
            : firestore()
                .collection('users')
                .doc(userId)
                .collection('games')
                .onSnapshot
                .map((s) => s.docs.map(_createGame).where((g) => g != null));

        final Stream<Iterable<GameState>> newGames = firestore()
            .collection('games')
            .onSnapshot
            .map((s) => s.docs.map(_createNewGame).where((x) => x != null));

        return Observable.combineLatest2(
          userGames,
          newGames,
          (Iterable<GameState> userGames, Iterable<GameState> newGames) {
            final userGameIds = userGames.map((g) => g.id).toList();
            return [
              ...userGames,
              ...newGames.where((g) => !userGameIds.contains(g.id))
            ];
          },
        );
      });

  Stream<GameState> getGame(String gameId) =>
      Observable(_authService.user.map((u) => u?.uid)).switchMap((userId) {
        if (userId == null) return Observable.just(null);
        return firestore()
            .collection('users')
            .doc(userId)
            .collection('games')
            .doc(gameId)
            .onSnapshot
            .map(_createGame);
      });

  Future<void> startGame(String userId, String gameId) async {
    await firestore()
        .collection('users')
        .doc(userId)
        .collection('games')
        .doc(gameId)
        .set({}, SetOptions(merge: true));
  }

  Stream<Question> getCurrentQuestion(String userId, String gameId) {
    return firestore()
        .collection('users')
        .doc(userId)
        .collection('games')
        .doc(gameId)
        .collection('questions')
        .orderBy('position')
        .onSnapshot
        .map((s) => s.docs
            .map((d) => d.data())
            .map((d) => Question.fromJson(d))
            .firstWhere(
              (q) => q.answer == null,
              orElse: () => null,
            ));
  }

  Future<void> answerQuestion(
    String userId,
    String gameId,
    String questionId,
    String answerId,
  ) async {
    return firestore()
        .collection('users')
        .doc(userId)
        .collection('games')
        .doc(gameId)
        .collection('questions')
        .doc(questionId)
        .update(data: {'answer': answerId});
  }

  GameState _createGame(DocumentSnapshot snapshot) {
    if (!snapshot.exists) return null;
    final d = snapshot.data();
    if (d.isEmpty) return null;

    final start = d['start'];
    final end = d['end'];

    if (end != null) {
      return GameState.completed(GameCompleted.fromJson(d));
    }

    final state = start == null
        ? GameState.newGame(GameNew.fromJson(d))
        : GameState.inProgress(GameInProgress.fromJson(d));

    return state;
  }

  GameState _createNewGame(DocumentSnapshot snapshot) =>
      GameState.newGame(GameNew.fromJson(snapshot.data()));
}
