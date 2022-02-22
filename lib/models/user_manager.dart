import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:lojavirtual/helpers/firebase.errors.dart';
import 'package:lojavirtual/models/user_app.dart';

class UserManager extends ChangeNotifier {
  UserManager() {
    _loadCurrentUser();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  User user;

  bool _loading = false;
  bool get loading => _loading;

  Future<void> signIn(
      {UserApp userApp, Function onFail, Function onSuccess}) async {
    loading = true;

    try {
      // ignore: unused_local_variable
      final UserCredential result = await auth.signInWithEmailAndPassword(
        email: userApp.email,
        password: userApp.password,
      );

      user = result.user;

      onSuccess();
    } on FirebaseAuthException catch (e) {
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

  Future<void> signUp(
      {UserApp userApp, Function onFail, Function onSucess}) async {
    loading = true;
    try {
      final UserCredential result = await auth.createUserWithEmailAndPassword(
          email: userApp.email, password: userApp.password);

      this.user = result.user;

      onSucess();
    } on FirebaseAuthException catch (e) {
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> _loadCurrentUser() async {
    final User currentUser = auth.currentUser;
    if (currentUser != null) {
      user = currentUser;
      print(user.uid);
    }
    notifyListeners();
  }
}
