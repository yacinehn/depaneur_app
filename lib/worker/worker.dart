import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
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
  String? mId;
  Set<Marker> _markers = {};
  void _listenForAlerts() {
    final DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref().child('Accident');

    databaseReference.onChildAdded.listen((event) {
      final alertData = event.snapshot.value as Map<dynamic, dynamic>;

      try {
        final alertKey = alertData['alertKey'] as String;
        final locationData = alertData['location'];
        final description = alertData['description'] as String;
        final image = alertData['image'] as String;
        final phoneNumber = alertData['phoneNumber'] as String;

        if (locationData is Map<dynamic, dynamic>) {
          final latitude = locationData['latitude'] as double;
          final longitude = locationData['longitude'] as double;

          final marker = Marker(
            markerId: MarkerId(alertKey),
            position: LatLng(latitude, longitude),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          );

          setState(() {
            mId = alertKey;
            _markers.add(marker);
          });

          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('New Alert'),
                  content: Column(
                    children: [
                      Image.network(image),
                      const SizedBox(height: 10),
                      Text('Description: $description'),
                      const SizedBox(height: 10),
                      Text('Phone Number: $phoneNumber'),
                    ],
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        // Handle action
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              });
        }
      } catch (e) {
        // ignore: avoid_print
        print('Error handling alert: $e');
      }
    });
  }

  Future<void> _acceptAlert() async {
    setState(() {
      _markers.removeWhere((marker) => marker.markerId.value == mId);
      mId = null;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Alert accepted')),
    );
  }

  @override
  void initState() {
    _listenForAlerts();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      drawer: Drawer(
        child: Column(children: [
          const UserAccountsDrawerHeader(
            currentAccountPicture:
                CircleAvatar(backgroundImage: AssetImage('images/dep.png')),
            accountName: Text(" Akrem "),
            accountEmail: Text("0777761754"),
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
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: const CameraPosition(
          target: LatLng(36.813020, 7.716708),
          zoom: 15.45,
        ),
        markers: _markers,
      ),
      floatingActionButton: SizedBox(
        width: 90,
        height: 90,
        child: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 7, 206, 110),
          heroTag: 'customSize',
          onPressed: () => _acceptAlert(),
          child: const Text(
            "Accept",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
