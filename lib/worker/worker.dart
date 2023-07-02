import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../application_state.dart';

class Worker extends StatefulWidget {
  const Worker({super.key});

  @override
  State<Worker> createState() => _WorkerState();
}

class _WorkerState extends State<Worker> {
  Set<Marker> _markers = {};
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Agent App'),
          backgroundColor: Colors.blue,
          centerTitle: true,
        ),
        drawer: Drawer(
          child: Column(children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture:
                  CircleAvatar(backgroundImage: AssetImage('images/dep.png')),
              accountName: Text("akrem fezari"),
              accountEmail: Text("akremfezari@agent.com"),
            ),
            ListTile(
              title: const Text(
                "Settings",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              leading: const Icon(Icons.settings),
              onTap: () {},
            ),
            const Spacer(),
            ListTile(
                title: const Text(
                  "logout",
                  style: TextStyle(fontSize: 20, color: Colors.red),
                ),
                leading: const Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  ApplicationState state =
                      Provider.of<ApplicationState>(context, listen: false);
                  state.setLoggedIn(false);
                }),
          ]),
        ),
        body: Column(
          children: [Text('bro just work')],
        ));
  }
}
