import 'worker/worker.dart';
import 'package:depaneur_app/signin/welcome.dart';
import 'package:depaneur_app/user/home.dart';

import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

class ApplicationState extends ChangeNotifier {
  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;

  ApplicationState() {
    init();
  }

  Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FirebaseUIAuth.configureProviders([
      EmailAuthProvider(),
    ]);

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        setLoggedIn(true);
      } else {
        setLoggedIn(false);
      }
    });
  }

  void setLoggedIn(bool value) {
    _loggedIn = value;
    notifyListeners();
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
    setLoggedIn(false);
  }

  Widget getHomePage() {
    final user = FirebaseAuth.instance.currentUser;
    if (loggedIn && user != null) {
      if (user.email?.endsWith('@user.com') ?? false) {
        return const home();
      } else {
        return const Worker();
      }
    } else {
      return const welcome(); // Replace LoginPage with your login page widget
    }
  }
}
