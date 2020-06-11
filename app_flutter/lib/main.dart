import 'package:app_flutter/router.dart';
import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  initApp();
  final authService = AuthService();

  final app = MultiProvider(
    providers: [
      Provider.value(value: authService),
      Provider.value(value: GameService(authService)),
      Provider.value(value: EventService()),
      Provider.value(value: ResultsService()),
    ],
    child: MewsChallengeApp(),
  );
  runApp(app);
}

class MewsChallengeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Mews Challenge',
        onGenerateRoute: router.generator,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFF101B2C),
          fontFamily: 'Montserrat',
          textTheme: const TextTheme(
            bodyText2: TextStyle(
              color: Color(0xFFFFFFFF),
            ),
          ),
        ),
      );
}

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }
}
