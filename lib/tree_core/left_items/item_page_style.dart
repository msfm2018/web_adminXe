import 'package:flutter/material.dart';

container(color, text) => Container(
      height: 32,
      alignment: Alignment.center,
      color: color,
      child: Text(
        text,
      ),
    );


var selectedButtonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all<Color>(Colors.blue[200]!), // 设置背景颜色
  foregroundColor: MaterialStateProperty.resolveWith<Color?>(foregroundColor),
  padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero), // 设置内边距为零
  minimumSize: MaterialStateProperty.all<Size>(const Size(44, 40)),
  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  alignment: Alignment.center,
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0), // 设置圆角半径
    ),
  ),
  side: MaterialStateProperty.all<BorderSide>(
    const BorderSide(width: 1.0, color: Colors.white), // 设置边框宽度和颜色
  ),
  iconColor: MaterialStateProperty.all<Color?>(Colors.white),
  iconSize: MaterialStateProperty.all(15),
);



var buttonStyle = ButtonStyle(
  overlayColor: MaterialStateProperty.resolveWith<Color?>(overlayColor),
  foregroundColor: MaterialStateProperty.resolveWith<Color?>(foregroundColor),
  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
  backgroundColor: MaterialStateProperty.all(Colors.transparent),
);

Color? overlayColor(Set<MaterialState> states) {
  if (states.contains(MaterialState.focused)) {
    return Colors.grey.withOpacity(0.8);
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
