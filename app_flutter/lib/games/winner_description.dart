import 'package:app_flutter/common/card.dart';
import 'package:flutter/widgets.dart';

class WinnerDescription extends StatelessWidget {
  const WinnerDescription(this.description, {Key key}) : super(key: key);

  final String description;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Text('For the winners', style: _subtitleStyle),
          ),
          MewsCard(
            child: Column(
              children: <Widget>[
                Image.asset(
                  'assets/winner.png',
                  width: double.infinity,
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    description,
                    style: _winnerCardTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}

const _winnerCardTextStyle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w500,
  height: 1.5,
  color: Color(0xFF101B2C),
  fontFamily: 'Montserrat',
);

final _linkTextStyle = _winnerCardTextStyle.copyWith(
  color: const Color(0xFF0091FB),
  decoration: TextDecoration.underline,
);

const _subtitleStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
);
