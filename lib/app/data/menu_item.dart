import 'package:flutter/material.dart';

class MenuItem {
  final IconData icon;
  final String title;
  final int? route;
  final String? routeName;

  MenuItem(this.icon, this.title, {this.route, this.routeName});
}
