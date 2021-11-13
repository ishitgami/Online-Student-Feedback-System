import 'package:flutter/material.dart';

class LogoHeading extends StatelessWidget {
  const LogoHeading({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(left: 20, top: 8),
          color: Colors.blueAccent,
          height: 110.0,
          width: 10.0,
        ),
        Container(
          height: 115,
          margin: EdgeInsets.only(left: 20, top: 8),
          child: Text(
            'ONLINE\nSTUDENT\nFEEDBACK\nSYSTEM',
            style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.w900,
                color: Colors.blueAccent),
          ),
        ),
      ],
    );
  }
}