library core;

import 'package:firebase/firebase.dart';

export 'src/auth_service.dart';
export 'src/game/game.dart';
export 'src/game/game_service.dart';
export 'src/game/question.dart';
export 'src/results/result.dart';
export 'src/results/results_service.dart';
export 'src/utils.dart';

const _apiKey = '__FIREBASE_API_KEY__';
const _projectId = '__FIREBASE_PROJECT_ID__';

void initApp() {
  initializeApp(
    apiKey: _apiKey,
    authDomain: '$_projectId.firebaseapp.com',
    projectId: '$_projectId',
    storageBucket: 'gs://$_projectId.appspot.com',
  );
}
