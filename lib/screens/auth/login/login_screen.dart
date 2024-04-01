import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

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
            onPressed: () async {
              // Navigator.pushNamed(context, '/select_action');
              String url = "http://113.178.50.42:4869/api/v1/auth/login";
              try {
                await Dio()
                    .fetch(RequestOptions(path: url, method: 'POST', data: {
                      "username": "user1",
                      "password": "asd123",
                    }, headers: {
                      'Content-Type': 'application/json'
                    }))
                    .then((value) => Logger().i(value))
                    .catchError((e) => Logger().e(e));
                ;
              } catch (e) {
                Logger().e(e);
              }
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
