import 'package:app_flutter/common/card.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:universal_html/html.dart' as html;

class WinnerDescription extends StatelessWidget {
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
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                              'We will announce the winners (fastest and most '
                              'accurate) on Saturday at 15:00 at our booth. '
                              'Winner in each game will get a voucher for one '
                              'hour of jacuzzi in hotel ',
                          style: _winnerCardTextStyle,
                        ),
                        TextSpan(
                          text: 'Emblem',
                          style: _linkTextStyle,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              html.window.open(
                                'https://www.emblemprague.com/homepage',
                                '_blank',
                              );
                            },
                        ),
                        TextSpan(
                          text: '.',
                          style: _winnerCardTextStyle,
                        ),
                      ],
                    ),
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
