import 'package:flutter/material.dart';

// class RoundedButton extends StatelessWidget {
//   final String title;
//   final dynamic color;
//   final Function onPressed;

//   RoundedButton({this.title, this.color, this.onPressed});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 10.0),
//       child: Container(
//         decoration: BoxDecoration(
//           gradient: color,
//         ),
//         child: Material(
//           // color: color,
//           borderRadius: BorderRadius.all(Radius.circular(30.0)),
//           elevation: 5.0,
//           child: InkWell(
//             onTap: onPressed,
//             // minWidth: 200.0,
//             // height: 42.0,
//             child: Text(
//               title,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class RoundedButton extends StatelessWidget {
  final String title;
  final Gradient gradient;
  final double width;
  final double height;
  final Function onPressed;
  final Color color;
  final Color borderColor;

  const RoundedButton({
    @required this.title,
    this.gradient,
    this.width = double.infinity,
    this.height = 50.0,
    this.color,
    this.onPressed,
    this.borderColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          side: BorderSide(color: borderColor),
        ),
        color: Colors.transparent,
        child: InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: onPressed,
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'BarlowSemiCondensed',
                  // fontFamily: 'SairaCondensed',
                  fontSize: 26,
                  color: color,
                ),
              ),
            )),
      ),
    );
  }
}
