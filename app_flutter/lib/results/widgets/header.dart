import 'package:flutter/widgets.dart';

class Header extends StatelessWidget {
  const Header({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 105),
        child: Row(
          children: <Widget>[
            const _Logo(),
            Text('Leaderboard', style: _headerStyle),
          ],
        ),
      );
}

class _Logo extends StatelessWidget {
  const _Logo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Padding(
        padding: const EdgeInsets.only(right: 32),
        child: Image.asset(
          'assets/logo_big.png',
          width: 56,
          height: 75,
        ),
      );
}

const _headerStyle = TextStyle(
  height: 1.2,
  fontSize: 48,
  fontWeight: FontWeight.w500,
);
