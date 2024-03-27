// ignore_for_file: must_be_immutable

// Flutter packages
import 'package:flutter/material.dart';
import '/utils/string_extensions.dart';

class MyTabBar extends StatefulWidget {
  MyTabBar({
    required this.items,
    required this.indexSelected,
    required this.onTap,
    this.showIcons = true,
    super.key,
  });

  final List<({IconData icon, String text})> items;
  final int indexSelected;
  final Function(int index) onTap;

  bool showIcons;

  @override
  State<MyTabBar> createState() => _MyTabBarState();
}

class _MyTabBarState extends State<MyTabBar> {
  Widget buildItem(int index, IconData iconData, String label) {
    return Expanded(
      child: GestureDetector(
        onTap: () => widget.onTap(index),
        child: widget.indexSelected == index
            ? Card(
                elevation: Theme.of(context).brightness == Brightness.light ? 1 : 4,
                margin: EdgeInsets.zero,
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.showIcons) Icon(iconData, size: 18),
                      if (widget.showIcons) const SizedBox(width: 5),
                      Flexible(
                        child: Text(
                          label.tight(),
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.showIcons) Icon(iconData, size: 18),
                    if (widget.showIcons) const SizedBox(width: 5),
                    Flexible(
                      child: Text(
                        label.tight(),
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.grey.withOpacity(0.2)
            : Color.alphaBlend(
                Colors.white.withOpacity(0.05),
                Theme.of(context).colorScheme.background,
              ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          ...List.generate(
            widget.items.length,
            (index) => buildItem(
              index,
              widget.items[index].icon,
              widget.items[index].text,
            ),
          ),
        ],
      ),
    );
  }
}
