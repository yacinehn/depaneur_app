import 'package:depaneur_app/accident.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../application_state.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String x = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Depaneur App'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 17, 32, 45),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('images/user.png'),
              ),
              accountName: Text("Zinedinne"),
              accountEmail: Text("0792752524"),
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
              },
            )
          ],
        ),
      ),
      body: Center(
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
          ),
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Accedent(
                      x: 'remorquage',
                    ),
                  ),
                );
                x = 'Remorquage';
              },
              child: Container(
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 52, 113, 226),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      "images/remarque.webp",
                      height: 130,
                      width: 120,
                    ),
                    const Text(
                      "Remorquage",
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Accedent(
                      x: 'accident',
                    ),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 189, 47, 11),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      "images/accedents.png",
                      height: 130,
                      width: 120,
                    ),
                    const Text(
                      "Accident",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Accedent(
                      x: 'crevaison',
                    ),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 232, 204, 46),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      "images/pneu.png",
                      height: 130,
                      width: 120,
                    ),
                    const Text(
                      "Crevaison",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Accedent(
                      x: 'autre',
                    ),
                  ),
                );
                x = 'Autre';
              },
              child: Container(
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 7, 29, 69),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      "images/autre.png",
                      height: 130,
                      width: 120,
                    ),
                    const Text(
                      "Autre",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
