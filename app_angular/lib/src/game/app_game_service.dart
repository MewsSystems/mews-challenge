import 'package:rxdart/rxdart.dart';

class AppGameService {
  BehaviorSubject<String> currentGameId = BehaviorSubject.seeded(null);
}
