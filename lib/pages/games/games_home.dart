// Flutter Packages
import 'package:dollars/controllers/games/steam_controller.dart';
import 'package:dollars/models/games/steam_game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Widgets
import 'package:dollars/widgets/loading_shimmer.dart';
import 'package:dollars/widgets/response_widget.dart';

class GamesHome extends ConsumerStatefulWidget {
  const GamesHome({super.key});

  @override
  ConsumerState<GamesHome> createState() => _GamesHomeState();
}

class _GamesHomeState extends ConsumerState<GamesHome> {
  bool isLoading = true, isSuccess = false;
  late ({bool success, String message}) response;

  @override
  void initState() {
    super.initState();

    asyncInit();
  }

  void asyncInit() async {
    await ref.read(steamProvider.notifier).getSteamAccount();
    response = await ref.read(steamProvider.notifier).getSteamData();

    setState(() {
      isLoading = false;
      isSuccess = response.success;
    });
  }

  Widget buildGameCard(SteamGame game) {
    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    "https://cdn.cloudflare.steamstatic.com/steam/apps/${game.appId}/hero_capsule.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 40,
          alignment: Alignment.center,
          child: Text(
            game.name,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              // fontFamily: GoogleFonts.graduate().fontFamily,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(steamProvider);

    List<SteamGame> gamesList = ref.read(steamProvider).gamesList;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => ListView(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          children: [
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
              child: Container(height: 350),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: isLoading
                              ? Wrap(
                                  spacing: 15,
                                  runSpacing: 15,
                                  children: [
                                    ...List.generate(
                                      20,
                                      (index) => rectLoadingCard(400, width: 250),
                                    ),
                                  ],
                                )
                              : !isSuccess
                                  ? ResponseWidget(
                                      icon: Icons.error,
                                      iconColor: Theme.of(context).colorScheme.error,
                                      title: "Algo de Errado Aconteceu",
                                      subtitle: response.message,
                                    )
                                  : GridView.builder(
                                      shrinkWrap: true,
                                      itemCount: gamesList.length,
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: MediaQuery.of(context).size.width ~/ 280,
                                        mainAxisSpacing: 15,
                                        crossAxisSpacing: 15,
                                        childAspectRatio: 0.6,
                                      ),
                                      itemBuilder: (context, index) =>
                                          buildGameCard(gamesList[index]),
                                    ),
                        ),
                      ),
                      // if (!isLoading)
                      //   Card(
                      //     elevation: 2,
                      //     child: Padding(
                      //       padding: const EdgeInsets.all(20),
                      //       child: NumberPaginator(
                      //         numberPages: maxPages,
                      //         initialPage: currentPage - 1,
                      //         config: NumberPaginatorUIConfig(
                      //           buttonSelectedBackgroundColor: Theme.of(context).colorScheme.primary,
                      //           buttonUnselectedForegroundColor:
                      //               Theme.of(context).colorScheme.primary,
                      //         ),
                      //         onPageChange: changePage,
                      //       ),
                      //     ),
                      //   )
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
          ],
        ),
      ),
    );
  }
}
