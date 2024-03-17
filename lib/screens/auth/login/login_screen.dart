import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Center(
            child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.onSecondary,
                  blurRadius: 2,
                  offset: const Offset(1, 2), // changes position of shadow
                ),
              ]),
          width: 150,
          height: 50,
          child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/select_action');
            },
            child: Text(
              'Login',
              style: TextStyle(
                  fontSize: 20, color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
        )));
  }
}
