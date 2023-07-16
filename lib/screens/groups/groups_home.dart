// Flutter Packages
import 'package:flutter/material.dart';

class GroupsHome extends StatefulWidget {
  const GroupsHome({super.key});

  @override
  State<GroupsHome> createState() => _GroupsHomeState();
}

class _GroupsHomeState extends State<GroupsHome> {
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
