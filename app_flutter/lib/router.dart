import 'package:app_flutter/games/game_list_screen.dart';
import 'package:app_flutter/games/game_screen.dart';
import 'package:app_flutter/results/results_bloc.dart';
import 'package:app_flutter/results/results_screen.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

final HandlerFunc _root = (context, params) => GameListScreen();

final HandlerFunc _results = (context, params) => BlocProvider<ResultsBloc>(
      create: (_) => ResultsBloc(Provider.of(context), Provider.of(context)),
      child: ResultsScreen(eventId: params['eventId'][0]),
    );

final HandlerFunc _game = (context, params) => GameScreen(
      gameId: params['id'][0],
    );

final router = Router()
  ..define('/', handler: Handler(handlerFunc: _root))
  ..define('/results/:eventId', handler: Handler(handlerFunc: _results))
  ..define('/game/:id', handler: Handler(handlerFunc: _game));
