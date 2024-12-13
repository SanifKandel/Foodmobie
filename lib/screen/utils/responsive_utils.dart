import 'package:flutter/material.dart';

double responsiveHeight(
    BuildContext context, double portraitHeight, double landscapeHeight) {
  return MediaQuery.of(context).orientation == Orientation.portrait
      ? MediaQuery.of(context).size.height * portraitHeight
      : MediaQuery.of(context).size.height * landscapeHeight;
}

double responsiveWidth(
    BuildContext context, double portraitWidth, double landscapeWidth) {
  return MediaQuery.of(context).orientation == Orientation.portrait
      ? MediaQuery.of(context).size.width * portraitWidth
      : MediaQuery.of(context).size.width * landscapeWidth;
}
