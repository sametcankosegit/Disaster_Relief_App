import 'package:flutter/material.dart';

Color getColorForMagnitude(var magnitude) {
  if (magnitude >= 0 && magnitude <= 3) {
    return Colors.green;
  } else if (magnitude > 3 && magnitude <= 6) {
    return Colors.orange;
  } else {
    return Colors.red;
  }
}
