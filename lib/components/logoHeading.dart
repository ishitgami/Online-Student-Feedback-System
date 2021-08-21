import 'package:flutter/material.dart';

class HeadingLogo extends StatelessWidget {
  HeadingLogo({this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        children: [
          Container(
            color: color,
            height: 170.0,
            width: 10.0,
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'ONLINE\nSTUDENT\nFEEDBACK\nSYSTEM',
              style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.w900,
                  color: color),
            ),
          ),
        ],
      ),
    );
  }
}
