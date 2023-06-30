// ignore_for_file: must_be_immutable

// Flutter Packages
import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

class MyWindowFrame extends StatelessWidget {
  MyWindowFrame({required this.child, super.key});

  Widget child;

  Widget buildWindowButtons(ColorScheme colorScheme) {
    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors(colorScheme)),
        MaximizeWindowButton(colors: buttonColors(colorScheme)),
        CloseWindowButton(colors: closeButtonColors(colorScheme)),
      ],
    );
  }

  WindowButtonColors buttonColors(ColorScheme colorScheme) => WindowButtonColors(
        iconNormal: colorScheme.primary,
        mouseOver: colorScheme.primary.withOpacity(0.1),
      );

  WindowButtonColors closeButtonColors(ColorScheme colorScheme) => WindowButtonColors(
        iconNormal: colorScheme.primary,
        mouseOver: Colors.red.withOpacity(0.7),
      );

  @override
  Widget build(BuildContext context) {
    return WindowBorder(
      width: 0,
      color: Colors.transparent,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: WindowTitleBarBox(child: MoveWindow())),
              buildWindowButtons(Theme.of(context).colorScheme)
            ],
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
