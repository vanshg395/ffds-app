import 'package:flutter/material.dart';

class LogoText extends StatelessWidget {
  final String type;
  final Color textColor;
  LogoText(this.type, this.textColor);

  @override
  Widget build(BuildContext context) {
    return Row(
      textBaseline: TextBaseline.alphabetic,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      children: <Widget>[
        Text(
          'F',
          style: TextStyle(
            fontSize: 80,
            fontFamily: 'BarlowSemiCondensed',
            color: textColor,
          ),
        ),
        type == 'large'
            ? Text(
                'ULLY',
                style: TextStyle(
                  fontSize: 40,
                  fontFamily: 'BarlowSemiCondensed',
                ),
              )
            : Text(''),
        Text(
          'F',
          style: TextStyle(
            fontSize: 80,
            fontFamily: 'BarlowSemiCondensed',
            color: textColor,
          ),
        ),
        type == 'large'
            ? Text(
                'LEXIBLE',
                style: TextStyle(
                  fontSize: 40,
                  fontFamily: 'BarlowSemiCondensed',
                ),
              )
            : Text(''),
        Text(
          'D',
          style: TextStyle(
            fontSize: 80,
            fontFamily: 'BarlowSemiCondensed',
            color: textColor,
          ),
        ),
        type == 'large'
            ? Text(
                'ATING',
                style: TextStyle(
                  fontSize: 40,
                  fontFamily: 'BarlowSemiCondensed',
                ),
              )
            : Text(''),
        Text(
          'S',
          style: TextStyle(
            fontSize: 80,
            fontFamily: 'BarlowSemiCondensed',
            color: textColor,
          ),
        ),
        type == 'large'
            ? Text(
                'YSTEM',
                style: TextStyle(
                  fontSize: 40,
                  fontFamily: 'BarlowSemiCondensed',
                ),
              )
            : Text(''),
      ],
    );
    // return Column(
    //   textBaseline: TextBaseline.ideographic,
    //   crossAxisAlignment: CrossAxisAlignment.baseline,
    //   // crossAxisAlignment: CrossAxisAlignment.center,
    //   children: <Widget>[
    //     Row(
    //       textBaseline: TextBaseline.alphabetic,
    //       crossAxisAlignment: CrossAxisAlignment.baseline,
    //       children: <Widget>[
    //         Text(
    //           'F',
    //           style: TextStyle(
    //             fontSize: 80,
    //             fontFamily: 'BarlowSemiCondensed',
    //             color: Color(0xFF06AD71),
    //           ),
    //         ),
    //         Text(
    //           'ULLY',
    //           style: TextStyle(
    //             fontSize: 40,
    //             fontFamily: 'BarlowSemiCondensed',
    //           ),
    //         ),
    //       ],
    //     ),
    //     Row(
    //       textBaseline: TextBaseline.alphabetic,
    //       crossAxisAlignment: CrossAxisAlignment.baseline,
    //       children: <Widget>[
    //         Text(
    //           'F',
    //           style: TextStyle(
    //             fontSize: 80,
    //             fontFamily: 'BarlowSemiCondensed',
    //             color: Color(0xFF06AD71),
    //           ),
    //         ),
    //         Text(
    //           'LEXIBLE',
    //           style: TextStyle(
    //             fontSize: 40,
    //             fontFamily: 'BarlowSemiCondensed',
    //           ),
    //         ),
    //       ],
    //     ),
    //     Row(
    //       textBaseline: TextBaseline.alphabetic,
    //       crossAxisAlignment: CrossAxisAlignment.baseline,
    //       children: <Widget>[
    //         Text(
    //           'D',
    //           style: TextStyle(
    //             fontSize: 80,
    //             fontFamily: 'BarlowSemiCondensed',
    //             color: Color(0xFF06AD71),
    //           ),
    //         ),
    //         Text(
    //           'ATING',
    //           style: TextStyle(
    //             fontSize: 40,
    //             fontFamily: 'BarlowSemiCondensed',
    //           ),
    //         ),
    //       ],
    //     ),
    //     Row(
    //       textBaseline: TextBaseline.alphabetic,
    //       crossAxisAlignment: CrossAxisAlignment.baseline,
    //       children: <Widget>[
    //         Text(
    //           'S',
    //           style: TextStyle(
    //             fontSize: 80,
    //             fontFamily: 'BarlowSemiCondensed',
    //             color: Color(0xFF06AD71),
    //           ),
    //         ),
    //         Text(
    //           'YSTEM',
    //           style: TextStyle(
    //             fontSize: 40,
    //             fontFamily: 'BarlowSemiCondensed',
    //           ),
    //         ),
    //       ],
    //     ),
    //   ],
    // );
  }
}
