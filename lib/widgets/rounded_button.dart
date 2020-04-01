import 'package:flutter/material.dart';

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
    this.height = 60.0,
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
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: borderColor),
        ),
        color: Colors.transparent,
        child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: onPressed,
            child: Center(
              child: Text(
                title.toUpperCase(),
                style: TextStyle(
                  letterSpacing: 2,
                  fontSize: 26,
                  color: color,
                ),
              ),
            ),),
      ),
    );
  }
}
