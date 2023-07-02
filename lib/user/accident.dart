import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_database/firebase_database.dart';

class accedent extends StatefulWidget {
  const accedent({super.key});

  @override
  State<accedent> createState() => _accedentState();
}

class _accedentState extends State<accedent> {
  File? _imageFile;
  final Accident = FirebaseDatabase.instance.ref('Accident');

  Future<void> _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Declaration'),
          backgroundColor: const Color.fromARGB(255, 17, 32, 45),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.fromLTRB(00, 20, 00, 00),
          child: Column(children: [
            Column(
              children: [
                const Text(
                  "Get my position",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 8.0),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.location_on),
                  label: const Text("Ebtenir ma position"),
                  style: ButtonStyle(
                    // Customize the button's appearance here
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(
                            255, 95, 38, 142)), // Set the background color
                    foregroundColor: MaterialStateProperty.all(
                        Colors.white), // Set the text colo

                    padding: MaterialStateProperty.all(
                        const EdgeInsets.all(12)), // Set the padding
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8), // Set the border radius
                        side: const BorderSide(
                            color: Colors.black), // Set the border color
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _takePicture();
              },
              style: ButtonStyle(
                // Customize the button's appearance here
                backgroundColor: MaterialStateProperty.all(const Color.fromARGB(
                    255, 95, 38, 142)), // Set the background color
                foregroundColor: MaterialStateProperty.all(
                    Colors.white), // Set the text colo

                padding: MaterialStateProperty.all(
                    const EdgeInsets.all(12)), // Set the padding
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(8), // Set the border radius
                    side: const BorderSide(
                        color: Colors.black), // Set the border color
                  ),
                ),
              ),
              child: const Text('take picture'),
            ),
            const SizedBox(height: 16.0),
            Container(
              margin: const EdgeInsets.fromLTRB(40, 00, 20, 20),
              height: 200,
              width: 300,
              decoration: BoxDecoration(
                border:
                    Border.all(color: const Color.fromARGB(255, 77, 27, 216)),
              ),
              child: _imageFile == null
                  ? const Center(
                      child: Text('Choose Image'),
                    )
                  : Image.file(
                      _imageFile!,
                      fit: BoxFit.cover,
                    ),
            ),
            const SizedBox(height: 10.0),
            const Text(
              'votre probleme',
              style: TextStyle(fontSize: 20),
            ),
            TextFormField(
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 25.0),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Send'),
              style: ButtonStyle(
                // Customize the button's appearance here
                backgroundColor: MaterialStateProperty.all(const Color.fromARGB(
                    255, 11, 134, 67)), // Set the background color
                foregroundColor: MaterialStateProperty.all(
                    Colors.white), // Set the text colo

                padding: MaterialStateProperty.all(
                    const EdgeInsets.all(12)), // Set the padding
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(8), // Set the border radius
                    side: const BorderSide(
                        color: Colors.black), // Set the border color
                  ),
                ),
              ),
            ),
          ]),
        ));
  }

  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permission is denied.');
      }
    }

    return await Geolocator.getCurrentPosition();
  }
}
