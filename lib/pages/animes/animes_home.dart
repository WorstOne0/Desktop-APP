// Flutter Packages
import 'package:dollars/controllers/anime/anime_controller.dart';
import 'package:dollars/models/anime/anime.dart';
import 'package:dollars/widgets/loading_shimmer.dart';
import 'package:dollars/widgets/response_widget.dart';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';

class AnimesHome extends ConsumerStatefulWidget {
  const AnimesHome({super.key});

  @override
  ConsumerState<AnimesHome> createState() => _AnimesHomeState();
}

class _AnimesHomeState extends ConsumerState<AnimesHome> {
  bool isLoading = true, isSuccess = false;
  late ({bool success, String message}) response;

  ScrollController _scrollController = ScrollController();

  final NumberPaginatorController _controller = NumberPaginatorController();
  int currentPage = 1, maxPages = 1;

  @override
  void initState() {
    super.initState();

    asyncInit();
  }

  void asyncInit() async {
    response = await ref.read(animeProvider.notifier).getAnimeList();
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

  Widget buildAnimeCard(Anime anime) {
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

    int crossAxisCount = MediaQuery.of(context).size.width ~/ 350;

    List<Anime> animeList = ref.read(animeProvider).animeList;

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
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          "Anime List",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
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
                                      itemCount: animeList.length,
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: crossAxisCount,
                                        mainAxisSpacing: 15,
                                        crossAxisSpacing: 15,
                                        childAspectRatio: 0.6,
                                      ),
                                      itemBuilder: (context, index) =>
                                          buildAnimeCard(animeList[index]),
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
