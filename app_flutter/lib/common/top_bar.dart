import 'package:app_flutter/common/button.dart';
import 'package:core/core.dart';
import 'package:firebase/firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:universal_html/html.dart' as html;

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Row(
        children: <Widget>[
          GestureDetector(
            child: Image.asset('assets/logo_big.png', width: 24, height: 32),
            onTap: () {
              Navigator.of(context).pushNamed('/');
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: FlatButton(
              child: Text('About us', style: TextStyle(fontSize: 16)),
              textColor: Colors.white,
              onPressed: () {
                html.window.open('https://mewssystems.com', '_blank');
              },
            ),
          ),
          Expanded(child: Container()),
          StreamBuilder<User>(
              stream: authService.user,
              initialData: authService.currentUser,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Container();
                return FlatButton(
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: CircleAvatar(
                          backgroundColor: const Color(0xFF979797),
                          backgroundImage: NetworkImage(snapshot.data.photoURL),
                          radius: 12,
                        ),
                      ),
                      Text(
                        getFirstName(snapshot.data),
                        style: TextStyle(fontFeatures: []),
                      ),
                    ],
                  ),
                  textColor: const Color(0xFF969FAB),
                  onPressed: () {
                    showDialog(
                        context: context,
                        child: AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          titleTextStyle: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF101B2C),
                          ),
                          title: Align(
                            child: Text('Account'),
                            alignment: Alignment.topCenter,
                          ),
                          content: Text(_personalDataText),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('Cancel'),
                              onPressed: () => Navigator.pop(context),
                            ),
                            Button(
                              text: 'Log out',
                              onPressed: () async {
                                await authService.logout();
                                Navigator.of(context).pop();
                                await Navigator.of(context).pushNamed('/');
                              },
                            ),
                          ],
                        ));
                  },
                );
              }),
        ],
      ),
    );
  }
}

const _personalDataText = '''
Should you require deletion of your personal data, 
please contact us at tech.dr@mewssystems.com.
''';
