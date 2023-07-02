import 'package:depaneur_app/signin/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import '../application_state.dart';

class login_agent extends StatefulWidget {
  const login_agent({super.key});

  @override
  State<login_agent> createState() => _login_agentState();
}

class _login_agentState extends State<login_agent> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: (IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const welcome()));
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 20,
            color: Colors.black,
          ),
        )),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      const Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "login to your account",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[700],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                " phone number:",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w400),
                              ),
                              TextFormField(
                                controller: emailController,
                                decoration: const InputDecoration(
                                    hintText: "Enter your phone number",
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Colors.grey,
                                    ))),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                " Password:",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w400),
                              ),
                              TextFormField(
                                controller: passwordController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                    hintText: "Enter your password",
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Colors.grey,
                                    ))),
                              ),
                            ],
                          )
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: _isLoading
                        ? const CircularProgressIndicator()
                        : MaterialButton(
                            minWidth: 230,
                            height: 50,
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  _isLoading = true;
                                  _errorMessage = '';
                                });
                                try {
                                  await FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                    email: '${emailController.text}@worker.com',
                                    password: passwordController.text,
                                  );
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  // ignore: use_build_context_synchronously
                                  ApplicationState state =
                                      // ignore: use_build_context_synchronously
                                      Provider.of<ApplicationState>(
                                    context,
                                    listen: false,
                                  );
                                  state.setLoggedIn(true);
                                  // ignore: use_build_context_synchronously
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              state.getHomePage()));
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'user-not-found') {
                                    setState(() {
                                      _errorMessage = 'User not found';
                                    });
                                  } else if (e.code == 'wrong-password') {
                                    setState(() {
                                      _errorMessage = 'Wrong password';
                                    });
                                  } else {
                                    setState(() {
                                      _errorMessage =
                                          'Something went wrong, please try again';
                                    });
                                  }
                                } catch (e) {
                                  setState(() {
                                    _errorMessage =
                                        'Something went wrong, please try again';
                                  });
                                } finally {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                }
                              }
                            },
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            color: Colors.green,
                            child: const Text(
                              "Login",
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 100),
                    height: 150,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("images/dep.png"),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
