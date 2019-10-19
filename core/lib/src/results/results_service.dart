import 'package:firebase/firebase.dart';

import 'result.dart';

class ResultsService {
  Stream<List<Result>> get developerResults => results('developer');

  Stream<List<Result>> get designResults => results('design');

  Stream<List<Result>> results(String gameId) => firestore()
      .collection('results')
      .doc(gameId)
      .collection('results')
      .onSnapshot
      .map((q) => q.docs.map((d) => d.data()))
      .map((docs) => (docs
              .map((d) => Result.fromJson(d))
              .where((r) => r.start.isAfter(DateTime(2019, 9, 20, 9)))
              .toList()
                ..sort((r1, r2) {
                  final byResult =
                      r2.rightAnswerCount.compareTo(r1.rightAnswerCount);
                  final byTime = r1.duration.compareTo(r2.duration);
                  return byResult == 0 ? byTime : byResult;
                }))
          .take(10)
          .toList());
}
