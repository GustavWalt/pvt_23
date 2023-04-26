import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

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
          padding: EdgeInsets.fromLTRB(40, 8, 40, 8),
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Color.fromARGB(255, 189, 194, 197),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              hintText: 'Email address',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(40, 8, 40, 8),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              filled: true,
              fillColor: Color.fromARGB(255, 189, 194, 197),
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
              onPressed: () => context.go('/'),
            )),
      ]),
    );
  }
}
