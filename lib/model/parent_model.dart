import 'package:flutter/material.dart';

class ParentDetails {
  final int id;

  final String? firstName, lastName, profileUrl,phone;

  ParentDetails({required this.id, this.firstName, this.lastName, this.profileUrl = 'https://i.amz.mshcdn.com/3NbrfEiECotKyhcUhgPJHbrL7zM=/950x534/filters:quality(90)/2014%2F06%2F02%2Fc0%2Fzuckheadsho.a33d0.jpg',this.phone});

  factory ParentDetails.fromJson(Map<dynamic, dynamic> json) {
    return  ParentDetails(
      id: json['id'],
      firstName: json['name'],
      lastName: json['username'],
      phone: json['phone'],
    );
  }
}