import 'package:flutter/material.dart';

Widget container(text) => Container(
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(fontSize: 18),
      ),
    );

var buttonStyle = ButtonStyle(

  overlayColor: MaterialStateProperty.resolveWith<Color?>(overlayColor),
  foregroundColor: MaterialStateProperty.resolveWith<Color?>(foregroundColor),
  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(3))),
  backgroundColor: MaterialStateProperty.all(Colors.transparent),
);

text(text) => Text(
      text,
      style: const TextStyle(
        fontFamily: 'WorkSans',
        letterSpacing: 0.2,
        fontWeight: FontWeight.w400,
        color: Color(0xFF4A6572),
        fontSize: 14,
      ),
    );

Color? overlayColor(Set<MaterialState> states) {
  if (states.contains(MaterialState.focused)) {
    return Colors.grey.withOpacity(1.0);
  }
  if (states.contains(MaterialState.hovered)) {
    return Colors.blue[200];
  }
  return null;
}

Color? foregroundColor(Set<MaterialState> states) {
  if (states.contains(MaterialState.focused) || states.contains(MaterialState.hovered)) {
    return Colors.white;
  }
  return null;
}
