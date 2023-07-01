// Flutter Packages
import 'package:dollars/controllers/steam_controller.dart';
import 'package:dollars/widgets/my_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Controllers
import 'package:dollars/controllers/window_controller.dart';
// Widgets
import 'package:dollars/widgets/my_window_frame.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  void initState() {
    super.initState();

    // Window Controller
    ref.read(windowProvider.notifier).homeCallback();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyWindowFrame(
        child: LayoutBuilder(
          builder: (context, constraints) => Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Row(
              children: [
                // App Bar
                const MyNavBar(),

                // Content
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          "Destaques",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Card(
                        elevation: 2,
                        child: Container(
                          height: 350,
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  child: Text(
                                    "Seu Feed",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Card(
                                  elevation: 2,
                                  child: Container(
                                    height: 1400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  "Side Bar",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Card(
                                elevation: 2,
                                child: Container(
                                  height: 1400,
                                  width: 300,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
