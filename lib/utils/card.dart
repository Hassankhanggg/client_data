import 'package:flutter/material.dart';

class card {
  String name, email;
  int phone, id;
  card({this.email, this.name, this.phone, this.id});
}

List<card> cards = [
  card(
    name: "hassan",
    id: 1,
    email: "hassan@g.com",
    phone: 1234,
  ),
  card(
    name: "razi",
    id: 2,
    email: "razi@g.com",
    phone: 12345,
  ),
  card(
    name: "bashrii",
    id: 3,
    email: "bashrii@g.com",
    phone: 123456,
  )
];
