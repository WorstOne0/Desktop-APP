// Flutter Packages
import 'package:dollars/models/anime/jikan_anime.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Controllers
import '/controllers/anime/anime_controller.dart';
// Models
import '/models/anime/mal_anime.dart';
// Widgets
import '/widgets/response_widget.dart';
import '/widgets/loading_shimmer.dart';
import '/widgets/my_tab_bar.dart';

class AnimesDetails extends ConsumerStatefulWidget {
  const AnimesDetails({super.key});

  @override
  ConsumerState<AnimesDetails> createState() => _AnimesDetailsState();
}

class _AnimesDetailsState extends ConsumerState<AnimesDetails> with SingleTickerProviderStateMixin {
  bool isLoading = true, isSuccess = false;
  late ({bool success, String message}) response;

  @override
  void initState() {
    super.initState();

    asyncInit();
  }

  void asyncInit() async {
    response = await ref.read(animeProvider.notifier).getAnimeById();

    setState(() {
      isLoading = false;
      isSuccess = response.success;
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(animeProvider);

    JikanAnime? animeSelected = ref.read(animeProvider).animeSelected;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [Image.network(animeSelected?.coverImage ?? "")],
          ),
        ),
      ),
    );
  }
}
