import 'package:flutter/material.dart';


class BorderTextField extends StatelessWidget {
  BorderTextField({this.icon, this.text,this.onChanged,this.controller});

  final String text;
  final Icon icon;
  final Function onChanged;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller : controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: text,
        icon: icon,
      ),
    );
  }
}