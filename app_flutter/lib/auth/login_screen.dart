import 'package:app_flutter/auth/login_bloc.dart';
import 'package:app_flutter/auth/login_event.dart';
import 'package:app_flutter/auth/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const _LoginText(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: GestureDetector(
                onTap: state.isConsentEnabled
                    ? () => context.bloc<LoginBloc>().onConsentTriggered()
                    : null,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: state.isConsentGiven
                        ? const Color(0xFF0091FB)
                        : Colors.white,
                    border: state.isConsentGiven
                        ? null
                        : Border.all(color: const Color(0xFFBFBFBF)),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: state.isConsentGiven
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
              onPressed: state.isLoginEnabled
                  ? () => context
                      .bloc<LoginBloc>()
                      .onLoginRequested(AuthMethod.facebook)
                  : null,
            ),
            FlatButton(
              color: Colors.white,
              disabledColor: Colors.white.withOpacity(.5),
              textColor: const Color(0x8A000000),
              child: Text('Login with Google'),
              onPressed: state.isLoginEnabled
                  ? () => context
                      .bloc<LoginBloc>()
                      .onLoginRequested(AuthMethod.google)
                  : null,
            ),
          ],
        ),
      );
}

class _LoginText extends StatelessWidget {
  const _LoginText({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Text(
          'Please login',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
}
