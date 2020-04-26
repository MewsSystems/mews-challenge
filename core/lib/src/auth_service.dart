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

  Future<User> loginFacebook() async {
    final provider = FacebookAuthProvider();
    return _doLogin(provider);
  }

  Future<User> loginGoogle() async {
    final provider = GoogleAuthProvider();
    return _doLogin(provider);
  }

  Future<User> _doLogin(AuthProvider provider) async {
    try {
      final result = await auth().signInWithPopup(provider);

      await firestore().collection('users').doc(result.user.uid).set(
        <String, dynamic>{
          'name': result.user.displayName,
          'email': result.user.email,
        },
        SetOptions(merge: true),
      );
      return result.user;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
