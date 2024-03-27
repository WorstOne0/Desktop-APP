// ignore_for_file: constant_identifier_names

// Flutter Packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Screens
import '/pages/posts/posts_home.dart';
import '/pages/profile/profile_home.dart';
import '/pages/animes/animes_home.dart';
import '/pages/games/games_home.dart';
import '/pages/groups/groups_home.dart';
// Controllers
import '/controllers/route_controller.dart';
import '/controllers/user_controller.dart';
// Models
import '/models/user/user.dart';

class MyNavBar extends ConsumerStatefulWidget {
  const MyNavBar({super.key});

  @override
  ConsumerState<MyNavBar> createState() => _MyNavBarState();
}

class _MyNavBarState extends ConsumerState<MyNavBar> {
  bool _isNavBarOpen = true;

  @override
  Widget build(BuildContext context) {
    NavBarRoutes routeSelected = ref.watch(routeProvider).routeSelected;

    User user = ref.watch(userProvider).user!;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: _isNavBarOpen ? 200 : 75,
      child: Card(
        elevation: 2,
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MaterialButton(
                onPressed: () {
                  setState(() {
                    _isNavBarOpen = !_isNavBarOpen;
                  });
                },
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.menu),
                    if (_isNavBarOpen) const SizedBox(width: 10),
                    if (_isNavBarOpen) const Text("Nav Bar"),
                  ],
                ),
              ),
              Column(
                children: [
                  MaterialButton(
                    height: 55,
                    animationDuration: const Duration(milliseconds: 200),
                    onPressed: () {
                      // Change NavBar Route
                      ref.read(routeProvider).navigatorKey.currentState!.pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const PostsHome(),
                              settings: const RouteSettings(name: "posts_home.dart"),
                            ),
                          );

                      // Update NavBar Selected
                      ref.read(routeProvider.notifier).changeNavBarRoute(NavBarRoutes.HOME);
                      ref.read(routeProvider.notifier).handleRouteStack("replace all", "Home");
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    color: routeSelected == NavBarRoutes.HOME
                        ? Theme.of(context).colorScheme.primary
                        : null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.home),
                        if (_isNavBarOpen) const SizedBox(width: 10),
                        if (_isNavBarOpen) const Text("Home"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  MaterialButton(
                    height: 55,
                    animationDuration: const Duration(milliseconds: 200),
                    onPressed: () {
                      // Change NavBar Route
                      ref.read(routeProvider).navigatorKey.currentState!.pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const GamesHome(),
                              settings: const RouteSettings(name: "games_home.dart"),
                            ),
                          );

                      // Update NavBar Selected
                      ref.read(routeProvider.notifier).changeNavBarRoute(NavBarRoutes.GAMES);
                      ref.read(routeProvider.notifier).handleRouteStack("replace all", "Games");
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    color: routeSelected == NavBarRoutes.GAMES
                        ? Theme.of(context).colorScheme.primary
                        : null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.gamepad),
                        if (_isNavBarOpen) const SizedBox(width: 10),
                        if (_isNavBarOpen) const Text("Jogos"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  MaterialButton(
                    height: 55,
                    animationDuration: const Duration(milliseconds: 200),
                    onPressed: () {
                      // Change NavBar Route
                      ref.read(routeProvider).navigatorKey.currentState!.pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const AnimesHome(),
                              settings: const RouteSettings(name: "animes_home.dart"),
                            ),
                          );

                      // Update NavBar Selected
                      ref.read(routeProvider.notifier).changeNavBarRoute(NavBarRoutes.ANIMES);
                      ref.read(routeProvider.notifier).handleRouteStack("replace all", "Anime");
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    color: routeSelected == NavBarRoutes.ANIMES
                        ? Theme.of(context).colorScheme.primary
                        : null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.bookmark_add),
                        if (_isNavBarOpen) const SizedBox(width: 10),
                        if (_isNavBarOpen) const Text("Anime"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  MaterialButton(
                    height: 55,
                    animationDuration: const Duration(milliseconds: 200),
                    onPressed: () {
                      // Change NavBar Route
                      ref.read(routeProvider).navigatorKey.currentState!.pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const GroupsHome(),
                              settings: const RouteSettings(name: "groups_home.dart"),
                            ),
                          );

                      // Update NavBar Selected
                      ref.read(routeProvider.notifier).changeNavBarRoute(NavBarRoutes.GROUPS);
                      ref.read(routeProvider.notifier).handleRouteStack("replace all", "Group");
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    color: routeSelected == NavBarRoutes.GROUPS
                        ? Theme.of(context).colorScheme.primary
                        : null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.group),
                        if (_isNavBarOpen) const SizedBox(width: 10),
                        if (_isNavBarOpen) const Text("Grupos"),
                      ],
                    ),
                  ),
                ],
              ),
              MaterialButton(
                height: 70,
                onPressed: () {
                  // Change NavBar Route
                  ref.read(routeProvider).navigatorKey.currentState!.pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const ProfileHome(),
                          settings: const RouteSettings(name: "profile.dart"),
                        ),
                      );

                  // Update NavBar Selected
                  ref.read(routeProvider.notifier).changeNavBarRoute(NavBarRoutes.PROFILE);
                  ref.read(routeProvider.notifier).handleRouteStack("replace all", "Profile");
                },
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: routeSelected == NavBarRoutes.PROFILE ? 23 : 20,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: user.profilePicture != null
                          ? CircleAvatar(
                              radius: 20,
                              backgroundImage: Image.network(user.profilePicture!).image,
                            )
                          : null,
                    ),
                    if (_isNavBarOpen) const SizedBox(width: 10),
                    if (_isNavBarOpen)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.screenName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "@${user.userName}",
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          )
                        ],
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
