import 'package:app_flutter/games/game_list_screen.dart';
import 'package:app_flutter/games/game_screen.dart';
import 'package:app_flutter/results/results_screen.dart';
import 'package:core/core.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  initApp();
  final authService = AuthService();

  final app = MultiProvider(
    providers: [
      Provider.value(value: authService),
      Provider.value(value: GameService(authService)),
    ],
    child: MyApp(),
  );
  runApp(app);
}

final _router = Router()
  ..define(
    '/',
    handler: Handler(handlerFunc: (context, params) => GameListScreen()),
  )
  ..define(
    '/results',
    handler: Handler(handlerFunc: (context, params) => ResultsScreen()),
  )
  ..define(
    '/game/:id',
    handler: Handler(
      handlerFunc: (context, params) => GameScreen(
        gameId: params['id'][0],
      ),
    ),
  );

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      onGenerateRoute: _router.generator,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF101B2C),
        fontFamily: 'Montserrat',
        textTheme: const TextTheme(
          body1: TextStyle(
            color: Color(0xFFFFFFFF),
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _buttonTitle = 'Click me';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text(_buttonTitle),
              onPressed: () {
                Navigator.of(context).pushNamed('/results');
              },
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
