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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
                final message = await AuthService().registration(
                  email: _emailController.text,
                  password: _passwordController.text,
                );
                if (message!.contains('Success')) {
                  context.go('/home_page');
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
