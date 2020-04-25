import 'dart:ui';

import 'package:app_flutter/common/button.dart';
import 'package:app_flutter/common/card.dart';
import 'package:app_flutter/common/screen.dart';
import 'package:app_flutter/games/winner_description.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class GameListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Screen(
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
          Text(
            'Developer? Designer? Playful? Choose your game and '
            'show us what you\'ve got! Get it right, get it fast!',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF969FAB),
              height: 1.5,
            ),
          ),
          Container(height: 16),
          _buildGameCards(context),
          WinnerDescription(),
        ],
      );

  Widget _buildGameCards(BuildContext context) =>
      StreamBuilder<List<GameState>>(
        stream: Provider.of<GameService>(context).getGames('webexpo2019'),
        initialData: [],
        builder: (context, snapshot) {
          if (snapshot.data.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Column(
            children: snapshot.data
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
        },
      );
}

const _cardTextStyle = TextStyle(
  fontSize: 16,
  height: 1.5,
  color: Color(0xFF4C5C70),
);
