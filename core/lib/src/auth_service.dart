import 'package:firebase/firebase.dart';
import 'package:firebase/firestore.dart';
import 'package:rxdart/rxdart.dart';

class AuthService {
  AuthService() {
    auth().onAuthStateChanged.listen(_user.add);
  }

  final BehaviorSubject<User> _user = BehaviorSubject.seeded(null);

  Stream<User> get user => _user.stream;

  User get currentUser => _user.value;

  Future<void> logout() async {
    await auth().signOut();
  }

  Future<void> loginFacebook() async {
    final provider = FacebookAuthProvider();
    await _doLogin(provider);
  }

  Future<void> loginGoogle() async {
    final provider = GoogleAuthProvider();
    await _doLogin(provider);
  }

  Future<void> _doLogin(AuthProvider provider) async {
    try {
      final result = await auth().signInWithPopup(provider);

      await firestore().collection('users').doc(result.user.uid).set(
        {
          'name': result.user.displayName,
          'email': result.user.email,
        },
        SetOptions(merge: true),
      );
    } catch (e) {
      print(e);
    }
  }
}
