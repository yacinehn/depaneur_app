import 'package:depaneur_app/accident.dart';
import 'package:depaneur_app/signin/login_agent.dart';
import 'package:depaneur_app/signin/welcome.dart';
import 'package:depaneur_app/user/home.dart';
import 'worker/worker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'application_state.dart';
import 'signin/login.dart';
import 'signup/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ApplicationState()),
        // Add more providers here if needed
      ],
      child: Consumer<ApplicationState>(
        builder: (context, appState, _) {
          return MaterialApp(
            title: 'My App',
            routes: {
              "welcome": (context) => const welcome(),
              "login": (context) => const login(),
              "signup": (context) => const signup(),
              "login_agent": (context) => const login_agent(),
              "home": (context) => const home(),
              "accident": (context) => const Accedent(),
              "worker": (context) => const Worker()
            },
            home: appState.getHomePage(),
          );
        },
      ),
    );
  }
}
