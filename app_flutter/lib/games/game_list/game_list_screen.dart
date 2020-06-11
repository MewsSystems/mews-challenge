import 'dart:ui';

import 'package:app_flutter/common/button.dart';
import 'package:app_flutter/common/card.dart';
import 'package:app_flutter/common/screen.dart';
import 'package:app_flutter/games/game_list/game_list_bloc.dart';
import 'package:app_flutter/games/game_list/game_list_state.dart';
import 'package:app_flutter/games/winner_description.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      BlocBuilder<GameListBloc, GameListState>(
        builder: (context, state) {
          final event = state.event.getOrNull();
          return Screen(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Text(
                  'Test your skills!',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (event != null) ...[
                Text(
                  event.description,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF969FAB),
                    height: 1.5,
                  ),
                ),
                Container(height: 16),
              ],
              _buildGameCards(context, state.games),
              if (event?.winnersDescription?.isNotEmpty == true)
                WinnerDescription(event.winnersDescription),
            ],
          );
        },
      );

  Widget _buildGameCards(BuildContext context, Iterable<GameState> games) =>
      Column(
        children: games
            .map(
              (g) => MewsCard(
                padding: EdgeInsets.all(24),
                margin: EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      g.title,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF101B2C),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(g.description, style: _cardTextStyle),
                    ),
                    Button(
                      text: 'Start game',
                      onPressed: () {
                        Navigator.of(context).pushNamed('/game/${g.id}');
                      },
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      );
}

const _cardTextStyle = TextStyle(
  fontSize: 16,
  height: 1.5,
  color: Color(0xFF4C5C70),
);
