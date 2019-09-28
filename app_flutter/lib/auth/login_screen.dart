import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isConsentChecked = false;

  @override
  Widget build(BuildContext context) {
    final AuthService authService = Provider.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Text(
            'Please login',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: GestureDetector(
            onTap: () {
              setState(() {
                _isConsentChecked = !_isConsentChecked;
              });
            },
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color:
                    _isConsentChecked ? const Color(0xFF0091FB) : Colors.white,
                border: _isConsentChecked
                    ? null
                    : Border.all(color: const Color(0xFFBFBFBF)),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: _isConsentChecked
                    ? Image.asset(
                        'assets/checked.png',
                        width: 16,
                        height: 16,
                      )
                    : null,
              ),
            ),
          ),
        ),
        Text('I consent to receiving follow-up communication from the Mews '
            'recruiting team concerning participation results and potential '
            'employment opportunities.'),
        Text('Read more here.'),
        Container(height: 24),
        FlatButton(
          color: const Color(0xFF4267B2),
          disabledColor: const Color(0xFF4267B2).withOpacity(.5),
          textColor: Colors.white,
          child: Text('Continue with Facebook'),
          onPressed: _isConsentChecked
              ? () {
                  authService.loginFacebook();
                }
              : null,
        ),
        FlatButton(
          color: Colors.white,
          disabledColor: Colors.white.withOpacity(.5),
          textColor: const Color(0x8A000000),
          child: Text('Login with Google'),
          onPressed: _isConsentChecked
              ? () {
                  authService.loginGoogle();
                }
              : null,
        ),
      ],
    );
  }
}
