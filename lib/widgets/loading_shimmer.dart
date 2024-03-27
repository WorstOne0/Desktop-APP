import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget rectLoadingCard(double height, {double? width, bool isMaxHeight = false}) {
  return Shimmer.fromColors(
    baseColor: Colors.grey[500]!,
    highlightColor: Colors.grey[100]!,
    child: Container(
      height: isMaxHeight ? double.infinity : height,
      width: width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.1),
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
      ),
    ),
  );
}

Widget circleLoadingCard(double radius) {
  return Shimmer.fromColors(
    baseColor: Colors.grey[500]!,
    highlightColor: Colors.grey[100]!,
    child: Container(
      height: radius,
      width: radius,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.1),
        borderRadius: const BorderRadius.all(
          Radius.circular(50),
        ),
      ),
    ),
  );
}
