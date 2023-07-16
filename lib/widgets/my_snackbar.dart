// ignore_for_file: must_be_immutable

// Flutter Packages
import 'package:flutter/material.dart';

SnackBar mySnackBar(Color color, IconData icon, String text, {Duration? duration}) {
  return SnackBar(
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    ),
    dismissDirection: DismissDirection.horizontal,
    duration: duration ?? const Duration(seconds: 2),
    padding: EdgeInsets.zero,
    content: SizedBox(
      height: 55,
      child: Row(
        children: [
          Container(
            width: 8,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5),
                bottomLeft: Radius.circular(5),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Row(
            children: [
              Icon(
                icon,
                color: color,
              ),
              const SizedBox(width: 15),
              Text(
                text,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          )
        ],
      ),
    ),
  );
}
