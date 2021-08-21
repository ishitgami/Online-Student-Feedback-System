import 'package:flutter/material.dart';


class BorderTextField extends StatelessWidget {
  BorderTextField({this.icon, this.text,this.onChanged});

  final String text;
  final Icon icon;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: text,
        icon: icon,
      ),
    );
  }
}