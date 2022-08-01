import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class SwiftmedicsCZFirebaseUser {
  SwiftmedicsCZFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

SwiftmedicsCZFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<SwiftmedicsCZFirebaseUser> swiftmedicsCZFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<SwiftmedicsCZFirebaseUser>(
            (user) => currentUser = SwiftmedicsCZFirebaseUser(user));
