import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pvt_23/widgets/navigation_bar_widget.dart';

import '../../logic/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
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
                  'Sign in',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                )),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(40, 20, 40, 8),
            child: TextField(
              controller: _emailController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromARGB(255, 189, 194, 197),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                hintText: 'Email',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(40, 8, 40, 8),
            child: TextField(
              controller: _passwordController,
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
                child: const Text('Sign in'),
                //Should not go to group page here, just a placeholder
                onPressed: () async {
                  final message = await AuthService().login(
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
                  if (message!.contains('Success')) {
                    context.go('/profile_page');
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(message),
                    ),
                  );
                },
              )),
          const Center(
            child: Text(
              'OR',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
              height: 65,
              padding: const EdgeInsets.fromLTRB(55, 8, 55, 8),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: Colors.white),
                child: const Text('Register',
                    style: TextStyle(color: Colors.black)),
                onPressed: () => context.go('/register_page'),
              )),
        ],
      ),
    );
  }
}
