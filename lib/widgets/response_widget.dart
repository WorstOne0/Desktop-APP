// ignore_for_file: must_be_immutable

// Flutter Package
import 'package:flutter/material.dart';

class ResponseWidget extends StatelessWidget {
  ResponseWidget({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    this.action,
    super.key,
  });

  IconData icon;
  Color iconColor;
  String title, subtitle;
  Widget? action;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 90,
          ),
          const SizedBox(height: 30),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          if (action != null) const SizedBox(height: 30),
          if (action != null) action!,
        ],
      ),
    );
  }
}
