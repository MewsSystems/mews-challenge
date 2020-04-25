import 'package:firebase/firebase.dart' hide Query;
import 'package:firebase/firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rxdart/rxdart.dart';

import '../auth_service.dart';
import 'game.dart';
import 'question.dart';

part 'game_service.g.dart';

@JsonSerializable()
class GameInfo {
  GameInfo({this.id, this.title});

  final String id;
  final String title;

  static GameInfo fromJson(Map<String, dynamic> json) =>
      _$GameInfoFromJson(json);
}

class GameService {
  GameService(this._authService);

  final AuthService _authService;

  Future<List<GameInfo>> getGameInfoForEvent(String eventId) async =>
      firestore()
          .collection('games')
          .where('eventId', '==', eventId)
          .get()
          .then((snapshot) => snapshot.docs
              .map((d) => d.data())
              .map(GameInfo.fromJson)
              .toList());

  Stream<List<GameState>> getGames(String eventId) {
    final filterOperator = eventId == null ? '>' : '==';
    final filterValue = eventId ?? '';
    return Observable(_authService.user.map((u) => u?.uid)).switchMap((userId) {
      final Stream<Iterable<GameState>> userGames = userId == null
          ? Observable.just(<GameState>[])
          : firestore()
              .collection('users')
              .doc(userId)
              .collection('games')
              .where('eventId', filterOperator, filterValue)
              .onSnapshot
              .map((s) => s.docs.map(_createGame).where((g) => g != null));

      Query newGamesQuery = firestore()
          .collection('games')
          .where('eventId', filterOperator, filterValue);

      if (eventId == null) {
        newGamesQuery = newGamesQuery.where('isEventOnly', '==', false);
      }
      final Stream<Iterable<GameState>> newGames = newGamesQuery.onSnapshot
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
  }

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
        .set(<String, dynamic>{}, SetOptions(merge: true));
  }

  Future<List<Question>> getQuestions(String userId, String gameId) =>
      firestore()
          .collection('users')
          .doc(userId)
          .collection('games')
          .doc(gameId)
          .collection('questions')
          .orderBy('position')
          .get()
          .then((snapshot) =>
              snapshot.docs.map((d) => Question.fromJson(d.data())).toList());

  Stream<Question> getCurrentQuestion(String userId, String gameId) =>
      firestore()
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

  Future<void> answerQuestion(
    String userId,
    String gameId,
    String questionId,
    String answerId,
  ) async =>
      firestore()
          .collection('users')
          .doc(userId)
          .collection('games')
          .doc(gameId)
          .collection('questions')
          .doc(questionId)
          .update(data: <String, dynamic>{'answer': answerId});

  GameState _createGame(DocumentSnapshot snapshot) {
    if (!snapshot.exists) return null;
    final d = snapshot.data();
    if (d.isEmpty) return null;

    final dynamic start = d['start'];
    final dynamic end = d['end'];

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
