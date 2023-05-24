import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pvt_23/widgets/navigation_bar_widget.dart';

import '../../logic/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final db = FirebaseFirestore.instance;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  Future<void> loginUser() async {
    await AuthService().login(
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(40, 70, 40, 50),
          child: Image(
            image: AssetImage("assets/images/logo1.png"),
            height: 100,
            width: 100,
          ),
        ),
        const Center(
          child: Padding(
              padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
              child: Text(
                'Sign up',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              )),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(40, 20, 40, 8),
          child: TextField(
            controller: _nameController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Color.fromARGB(255, 189, 194, 197),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              hintText: 'Full name',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(40, 8, 40, 8),
          child: TextField(
            controller: _phoneController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Color.fromARGB(255, 189, 194, 197),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              hintText: 'Phone number',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 8, 40, 8),
          child: TextField(
            controller: _emailController,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color.fromARGB(255, 189, 194, 197),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              hintText: 'Email address',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 8, 40, 8),
          child: TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color.fromARGB(255, 189, 194, 197),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              hintText: 'Password',
            ),
          ),
        ),
        Container(
            height: 65,
            padding: const EdgeInsets.fromLTRB(55, 8, 55, 8),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: Colors.black),
              child: const Text('Register'),
              //Ska inte gå till Sign_in här, bara för test.
              onPressed: () async {
                if (_nameController.text == "" ||
                    _phoneController.text == "" ||
                    _emailController.text == "" ||
                    _passwordController.text == "") {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Error"),
                        content: const Text("Please fill in all fields"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("OK"),
                          ),
                        ],
                      );
                    },
                  );
                  return;
                }

                final message = await AuthService().registration(
                  email: _emailController.text,
                  password: _passwordController.text,
                );
                if (message!.contains('Success')) {
                  // Logga in användaren för nuvarande session
                  loginUser();
                  final FirebaseAuth auth = FirebaseAuth.instance;

                  // Hämta UID
                  final User? currentUser = auth.currentUser;
                  final uid = currentUser!.uid;

                  // Skicka till databas
                  final user = <String, dynamic>{
                    "fullname": _nameController.text,
                    "phone": int.parse(_phoneController.text),
                    "email": _emailController.text,
                    "uid": uid,
                    "groups": {},
                  };

                  await db.collection("users").doc(uid).set(user);

                  context.go('/group_page');
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                  ),
                );
              },
            )),
        Container(
            height: 65,
            padding: const EdgeInsets.fromLTRB(55, 8, 55, 8),
            child: Center(
                child: ElevatedButton(
              onPressed: () => context.go("/"),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [Icon(Icons.arrow_back), Text("Go back")],
              ),
            ))),
      ]),
    );
  }
}
