// Flutter Packages
import 'package:dollars/controllers/socket_io_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostsHome extends ConsumerStatefulWidget {
  const PostsHome({super.key});

  @override
  ConsumerState<PostsHome> createState() => _PostsHomeState();
}

class _PostsHomeState extends ConsumerState<PostsHome> {
  @override
  Widget build(BuildContext context) {
    print(ref.read(socketIOProvider).message);

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => ListView(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "Destaques",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Card(
              elevation: 2,
              child: Container(
                height: 350,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
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
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
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
                        padding: const EdgeInsets.all(20),
                        child: const Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Recent Chat",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "All",
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 100),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Recent Activity",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "All",
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Row(
          children: [
            Icon(Icons.add),
            SizedBox(width: 5),
            Text("Adicionar Post"),
          ],
        ),
      ),
    );
  }
}
