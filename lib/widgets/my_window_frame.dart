// ignore_for_file: must_be_immutable

// Flutter Packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
// Controlers
import '/controllers/route_controller.dart';

class MyWindowFrame extends ConsumerStatefulWidget {
  const MyWindowFrame({required this.child, required this.isLogin, super.key});

  final Widget child;
  final bool isLogin;

  @override
  ConsumerState<MyWindowFrame> createState() => _MyWindowFrameState();
}

class _MyWindowFrameState extends ConsumerState<MyWindowFrame> {
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
    List<String> routeStack = ref.read(routeProvider).routeStack;

    return WindowBorder(
      width: 0,
      color: Colors.transparent,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: WindowTitleBarBox(
                    child: MoveWindow(
                      child: widget.isLogin
                          ? null
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Left
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 40),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                        "DOLLARS",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 8,
                                        ),
                                      ),
                                      const SizedBox(width: 30),

                                      //
                                      Row(
                                        children: [
                                          ...routeStack
                                              .map(
                                                (route) => Row(
                                                  children: [
                                                    Text(
                                                      route,
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        height: 0.9,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 5),
                                                    const Icon(
                                                      Icons.keyboard_arrow_right,
                                                      size: 16,
                                                    ),
                                                    const SizedBox(width: 5),
                                                  ],
                                                ),
                                              )
                                              .toList()
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                // Right
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.settings,
                                          size: 18,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.notifications,
                                          size: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                    ),
                  ),
                ),
              ),
              buildWindowButtons(Theme.of(context).colorScheme)
            ],
          ),
          Expanded(child: widget.child),
        ],
      ),
    );
  }
}
