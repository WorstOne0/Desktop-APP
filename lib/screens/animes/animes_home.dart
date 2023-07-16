// Flutter Packages
import 'package:flutter/material.dart';

class AnimesHome extends StatefulWidget {
  const AnimesHome({super.key});

  @override
  State<AnimesHome> createState() => _AnimesHomeState();
}

class _AnimesHomeState extends State<AnimesHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Column(
            children: [
              Card(
                elevation: 2,
                child: Container(
                  height: 500,
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Card(
                        elevation: 2,
                        child: Container(),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Card(
                        elevation: 2,
                        child: Container(),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
