// Flutter Packages
import 'package:flutter/material.dart';

class GamesHome extends StatefulWidget {
  const GamesHome({super.key});

  @override
  State<GamesHome> createState() => _GamesHomeState();
}

class _GamesHomeState extends State<GamesHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) =>
            ListView(padding: const EdgeInsets.fromLTRB(20, 0, 20, 20), children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "Jogo Favorito",
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
              height: 500,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Theme.of(context).colorScheme.primary),
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  // https://wallpaperaccess.com/full/634033.png
                  image: Image.network("https://wallpaperaccess.com/full/147236.jpg").image,
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Tags

                  // Logo + Name
                  Row(
                    children: [
                      Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: Image.network(
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJ9uWVTeoFohglEiK8vlCoClSgbcoW0JSaxsc69Tr3bqL4mAF-aBGDhw2uRAJr44tHkSE&usqp=CAU",
                              fit: BoxFit.cover,
                            ).image,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.background,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Text(
                                  "FPS",
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.primary,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 5),
                              Container(
                                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.background,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Text(
                                  "Action",
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.primary,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Text(
                            "Counter Strike: Global Offensive",
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                              height: 1,
                              shadows: [Shadow(color: Colors.black, offset: Offset(1, 1))],
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
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
                        "Meus Jogos",
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
                        children: [],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
        ]),
      ),
    );
  }
}
