import 'package:app_flutter/common/card.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:universal_html/html.dart' as html;

class ResultWidget extends StatelessWidget {
  const ResultWidget({Key key, @required this.resultType}) : super(key: key);

  final ResultType resultType;

  @override
  Widget build(BuildContext context) {
    final data = _getData(resultType);
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: MewsCard(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Image.asset(
              'assets/${data.icon}.png',
              width: 72,
            ),
            if (data.title != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  data.title,
                  style: TextStyle(
                    color: const Color(0xFF101B2C),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            // Bug https://github.com/flutter/flutter/issues/39226
            // prevents from clicking the link.
            if (data.text != null)
              Html(
                data: data.text,
                defaultTextStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF4C5C70),
                ),
                onLinkTap: (url) {
                  html.window.open(url, '_blank');
                },
              ),
          ],
        ),
      ),
    );
  }

  ResultData _getData(ResultType resultType) {
    switch (resultType) {
      case ResultType.designEagleEye:
        return ResultData(
          'result-eagle',
          'EAGLE EYE!',
          '''
Looks like you know everything but did you know we have open positions? 
Check them out <a href="https://www.workable.com/j/D00CF6F801">here</a> 
and come see us at our booth in the Gallery, we\'ve got something for you.
''',
        );
      case ResultType.designSuperstar:
        return ResultData(
          'result-superstar',
          'Superstar!',
          '''
Looks like you know a lot but did you know we have open positions? Check them out
<a href="https://www.workable.com/j/D00CF6F801">here</a>
and come see us at our booth in the Gallery, we've got something for you.
''',
        );
      case ResultType.designNotBad:
        return ResultData(
          'result-not-bad',
          'Not bad... not bad...',
          null,
        );
      case ResultType.designNotGreat:
        return ResultData(
          'result-not-great',
          'Not great, not terrible',
          null,
        );
      case ResultType.robot:
        return ResultData(
          'result-robot',
          'ROBOT ALERT!',
          '''
Looks like you know everything but did you know we have open positions? 
Check them out <a href="https://github.com/MewsSystems/developers">here</a>
and come see us at our booth in the Gallery, we've got something for you.
''',
        );
      case ResultType.superstar:
        return ResultData(
          'result-superstar',
          'Superstar!',
          '''
Looks like you know a lot but did you know we have open positions? 
Check them out <a href="https://github.com/MewsSystems/developers">here</a>
and come see us at our booth in the Gallery, we've got something for you.
''',
        );
      case ResultType.notBad:
        return ResultData(
          'result-not-bad',
          'Not bad...',
          '''
Check out our <a href="https://github.com/MewsSystems/developers">GitHub</a>
for more information on how it is to be a Mewser. And come say hi to our 
booth in the Gallery, we've got something for you.
''',
        );
      case ResultType.frontend:
        return ResultData(
          null,
          null,
          '''
Looks like you’re a JavaScript fan. Wanna do
<a href="https://mews-systems.workable.com/j/02C70D4EE1?viewed=true">frontend</a>
in Mews?
''',
        );
      case ResultType.backend:
        return ResultData(
          null,
          null,
          '''
Looks like you’re a C# fan. Wanna do
<a href="https://mews-systems.workable.com/j/A351B0CD2C?viewed=true">backend</a>
in Mews?
''',
        );
      case ResultType.data:
        return ResultData(
          null,
          null,
          '''
Looks like you’re a data fan. Wanna work with
<a href="https://mews-systems.workable.com/j/1591AF3922?viewed=true">data</a>
in Mews?
''',
        );
      case ResultType.mobile:
        return ResultData(
          null,
          null,
          '''
Looks like you’re a mobile fan. Let’s keep in touch at
<a href="mailto:jobs@mewssystems.com">jobs@mewssystems.com</a>
''',
        );
      case ResultType.other:
        return ResultData(
          null,
          null,
          '''
Yeah, we made it tricky but maybe some parts were good? Check out our
<a href="https://github.com/MewsSystems/developers">GitHub</a>
for more. And come say hi to our booth in the Gallery, we've got 
something for you.
''',
        );
    }
  }
}

class ResultData {
  ResultData(this.icon, this.title, this.text);

  final String icon;
  final String title;
  final String text;
}
