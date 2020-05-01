import 'package:flutter/material.dart';


class IconContent extends StatelessWidget {

  final IconData ic ;
  final String gender;
  IconContent({@required this.ic,@required this.gender});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          ic,
          size: 80.0,
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(gender, style: TextStyle(
          fontSize: 18.0,
          color: Color(0xFF898B8F),
        ),)
      ],
    );
  }
}