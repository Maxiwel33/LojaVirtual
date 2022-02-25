import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:lojavirtual/helpers/firebase.errors.dart';
import 'package:lojavirtual/models/user_app.dart';

class UserManager extends ChangeNotifier {
  UserManager() {
    _loadCurrentUser();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  //User user = FirebaseAuth.instance.currentUser;

  UserApp userApp;

  bool _loading = false;
  bool get loading => _loading;

  bool get isLoggedIn => UserApp != null;

  Future<void> signIn(
      {UserApp userApp, Function onFail, Function onSuccess}) async {
    loading = true;

    try {
      // ignore: unused_local_variable
      final UserCredential result = await auth.signInWithEmailAndPassword(
        email: userApp.email,
        password: userApp.password,
      );

      await _loadCurrentUser(firebaseAuth: FirebaseAuth.instance);

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

      userApp.id = result.user.uid;

      this.userApp = UserApp();

      await userApp.saveData();

      onSucess();
    } on FirebaseAuthException catch (e) {
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

  void signOut() {
    auth.signOut();
    userApp = null;
    notifyListeners();
  }

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> _loadCurrentUser({FirebaseAuth firebaseAuth}) async {
    final FirebaseAuth currentUser = firebaseAuth ?? auth.currentUser.uid;
    if (currentUser != null) {
      final DocumentSnapshot docUser =
          await firestore.collection('users').doc(currentUser.toString()).get();
      userApp = UserApp.fromDocument(docUser);
      notifyListeners();
    }
  }
}
