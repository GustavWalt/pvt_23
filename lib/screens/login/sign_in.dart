import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pvt_23/widgets/navigation_bar_widget.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const MenuWidget(),
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
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromARGB(255, 189, 194, 197),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                hintText: 'Email or phone number',
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
                child: const Text('Sign in'),
                //Ska inte gå till home page när man trycker på den här knappen, bara för test atm.
                onPressed: () => context.go('/home_page'),
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
                    backgroundColor: Colors.blue),
                child: const Text('Sign in with Facebook'),
                //Ska inte gå till sign_up när man trycker på den här knappen, bara för test atm.
                onPressed: () => context.go('/sign_up'),
              )),
          Container(
              height: 65,
              padding: const EdgeInsets.fromLTRB(55, 8, 55, 8),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: Colors.white),
                child: const Text('Sign in with Google',
                    style: TextStyle(color: Colors.black)),
                //Ska inte gå till sign_up när man trycker på den här knappen, bara för test atm.
                onPressed: () => context.go('/sign_up'),
              )),
        ],
      ),
    );
  }
}
