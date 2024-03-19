import 'package:flutter/material.dart';

import '../model/user_model.dart';

final List<User> users = [
  User(
      id: 1,
      username: 'admin1',
      password: 'admin1',
      token: null,
      created_at: DateTime.now(),
      status: true),
  User(
      id: 2,
      username: 'admin2',
      password: 'admin2',
      token: null,
      created_at: DateTime.now(),
      status: false),
  User(
      id: 3,
      username: 'admin3',
      password: 'admin3',
      token: null,
      created_at: DateTime.now(),
      status: true),
  User(
      id: 4,
      username: 'admin4',
      password: 'admin4',
      token: null,
      created_at: DateTime.now(),
      status: false),
];
