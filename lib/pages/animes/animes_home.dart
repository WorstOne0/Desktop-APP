// Flutter Packages
import 'package:dollars/controllers/core/route_controller.dart';
import 'package:dollars/pages/animes/animes_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';
// Controllers
import '/controllers/anime/anime_controller.dart';
// Models
import '/models/anime/mal_anime.dart';
// Widgets
import '/widgets/response_widget.dart';
import '/widgets/loading_shimmer.dart';
import '/widgets/my_tab_bar.dart';

class AnimesHome extends ConsumerStatefulWidget {
  const AnimesHome({super.key});

  @override
  ConsumerState<AnimesHome> createState() => _AnimesHomeState();
}

class _AnimesHomeState extends ConsumerState<AnimesHome> with SingleTickerProviderStateMixin {
  bool isLoading = true, isSuccess = false;
  late ({bool success, String message}) response;

  // Tabs
  late TabController _tabController;
  int currentTab = 0;
  //
  final _scrollController = ScrollController();

  int currentPage = 1, maxPages = 1;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(
      () => setState(() {
        currentTab = _tabController.index;
      }),
    );

    asyncInit();
  }

  void asyncInit() async {
    response = await ref.read(animeProvider.notifier).getUserAnimeList();
    maxPages = ref.read(animeProvider.notifier).maxPages;

    setState(() {
      isLoading = false;
      isSuccess = response.success;
    });
  }

  void changePage(int page) async {
    if (isLoading) return;

    setState(() => isLoading = true);

    currentPage = page + 1;

    _scrollController.jumpTo(395);

    response = await ref.read(animeProvider.notifier).getAnimeList(page: currentPage);
    maxPages = ref.read(animeProvider.notifier).maxPages;

    setState(() {
      isLoading = false;
      isSuccess = response.success;
    });
  }

  Widget buildAnimeCard(MALAnime anime) {
    return Container(
      foregroundDecoration: anime.rank < 1000
          ? RotatedCornerDecoration.withColor(
              color: Theme.of(context).colorScheme.primary,
              spanBaselineShift: 2,
              badgeSize: const Size(57, 57),
              badgeCornerRadius: const Radius.circular(8),
              badgePosition: BadgePosition.topStart,
              textSpan: TextSpan(
                text: "# ${anime.rank}",
                style: const TextStyle(fontSize: 14),
              ),
            )
          : null,
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          anime.coverImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),

                Positioned(
                  top: 10,
                  left: 10,
                  right: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 7),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 16,
                              color: Colors.yellow,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              anime.score.toString(),
                              style: const TextStyle(fontSize: 12, color: Colors.white),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                // Genre
                Positioned(
                  bottom: 10,
                  left: 10,
                  right: 10,
                  child: Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    verticalDirection: VerticalDirection.up,
                    children: [
                      ...anime.genres.map(
                        (genre) => Container(
                          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            genre,
                            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 40,
            alignment: Alignment.center,
            child: Text(
              anime.title,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                // fontFamily: GoogleFonts.graduate().fontFamily,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List truncatePagination(currentPage, totalPage, {int neighbours = 5, wildCard = '...'}) {
    if (currentPage > totalPage) {
      throw Exception("currentPage cannot be greater than totalPage");
    }

    if (totalPage <= 3 + neighbours) {
      //adding wildcard is not required in this case
      return List<int>.generate(totalPage, (index) => index + 1);
    }

    var _pages = [1], _pagesUpdated = [], _prevPage;

    for (int i = currentPage - neighbours; i <= currentPage + neighbours; i++) {
      //make sure first and last pages are not repeated
      if (i < totalPage && i > 1) {
        _pages.add(i);
      }
    }
    _pages.add(totalPage);

    _pages.forEach((int page) {
      if (_prevPage != null) {
        if (page - _prevPage == 2) {
          //if the gap is 2 instead of showing ... show the actual number
          //eg. [1, 2, 3, 4, 5, ..., 20] is better than [1, ..., 3, 4, 5, ..., 20]
          //where 4 is the selected page
          // _pagesUpdated.add(_prevPage + 1);
        } else if (page - _prevPage != 1) {
          _pagesUpdated.add(wildCard);
        }
      }
      _pagesUpdated.add(page);
      _prevPage = page;
    });

    return _pagesUpdated;
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(animeProvider);

    List<MALAnime> malAnimeList = ref.read(animeProvider).malAnimeList;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => ListView(
          controller: _scrollController,
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "Animes em Destaque",
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 800,
                        child: Card(
                          elevation: 2,
                          child: MyTabBar(
                            items: const [
                              (icon: Icons.person, text: "Sua Lista"),
                              (icon: Icons.security, text: "Airing"),
                              (icon: Icons.abc, text: "All Anime")
                            ],
                            indexSelected: currentTab,
                            showIcons: false,
                            onTap: (value) {
                              currentTab = value;

                              setState(() {});
                              _tabController.animateTo(value);
                            },
                          ),
                        ),
                      ),
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
                                      itemCount: malAnimeList.length,
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: MediaQuery.of(context).size.width ~/ 280,
                                        mainAxisSpacing: 15,
                                        crossAxisSpacing: 15,
                                        childAspectRatio: 0.6,
                                      ),
                                      itemBuilder: (context, index) => GestureDetector(
                                        onTap: () {
                                          ref
                                              .read(animeProvider.notifier)
                                              .selectAnimeId(malAnimeList[index].malId);

                                          // Change NavBar Route
                                          ref.read(routeProvider).navigatorKey.currentState!.push(
                                                MaterialPageRoute(
                                                  builder: (context) => const AnimesDetails(),
                                                  settings: const RouteSettings(
                                                    name: "animes_details.dart",
                                                  ),
                                                ),
                                              );

                                          // Update NavBar Selected
                                          ref
                                              .read(routeProvider.notifier)
                                              .handleRouteStack("push", malAnimeList[index].title);
                                        },
                                        child: buildAnimeCard(
                                          malAnimeList[index],
                                        ),
                                      ),
                                    ),
                        ),
                      ),
                      if (!isLoading)
                        Card(
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: NumberPaginator(
                              numberPages: maxPages,
                              initialPage: currentPage - 1,
                              config: NumberPaginatorUIConfig(
                                buttonSelectedBackgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                buttonUnselectedForegroundColor:
                                    Theme.of(context).colorScheme.primary,
                              ),
                              onPageChange: changePage,
                            ),
                          ),
                        )
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  width: 300,
                  child: Column(
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
                          child: const Row(
                            children: [Text("data")],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
