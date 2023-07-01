// ignore_for_file: constant_identifier_names

// Flutter Packages
import 'package:flutter/material.dart';

enum NavBarRoutes { HOME, GAMES, ANIMES, GROUPS }

class MyNavBar extends StatefulWidget {
  const MyNavBar({super.key});

  @override
  State<MyNavBar> createState() => _MyNavBarState();
}

class _MyNavBarState extends State<MyNavBar> {
  bool _isNavBarOpen = true;

  NavBarRoutes routeSelected = NavBarRoutes.HOME;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
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
                    Icon(Icons.menu),
                    if (_isNavBarOpen) SizedBox(width: 10),
                    if (_isNavBarOpen) Text("DOLLARS"),
                  ],
                ),
              ),
              Column(
                children: [
                  MaterialButton(
                    height: 55,
                    animationDuration: Duration(milliseconds: 200),
                    onPressed: () {
                      setState(() {
                        routeSelected = NavBarRoutes.HOME;
                      });
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    color: routeSelected == NavBarRoutes.HOME
                        ? Theme.of(context).colorScheme.primary
                        : null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.home),
                        if (_isNavBarOpen) SizedBox(width: 10),
                        if (_isNavBarOpen) Text("Home"),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  MaterialButton(
                    height: 55,
                    animationDuration: Duration(milliseconds: 200),
                    onPressed: () {
                      setState(() {
                        routeSelected = NavBarRoutes.GAMES;
                      });
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    color: routeSelected == NavBarRoutes.GAMES
                        ? Theme.of(context).colorScheme.primary
                        : null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.gamepad),
                        if (_isNavBarOpen) SizedBox(width: 10),
                        if (_isNavBarOpen) Text("Jogos"),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  MaterialButton(
                    height: 55,
                    animationDuration: Duration(milliseconds: 200),
                    onPressed: () {
                      setState(() {
                        routeSelected = NavBarRoutes.ANIMES;
                      });
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    color: routeSelected == NavBarRoutes.ANIMES
                        ? Theme.of(context).colorScheme.primary
                        : null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.bookmark_add),
                        if (_isNavBarOpen) SizedBox(width: 10),
                        if (_isNavBarOpen) Text("Anime"),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  MaterialButton(
                    height: 55,
                    animationDuration: Duration(milliseconds: 200),
                    onPressed: () {
                      setState(() {
                        routeSelected = NavBarRoutes.GROUPS;
                      });
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    color: routeSelected == NavBarRoutes.GROUPS
                        ? Theme.of(context).colorScheme.primary
                        : null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.group),
                        if (_isNavBarOpen) SizedBox(width: 10),
                        if (_isNavBarOpen) Text("Grupos"),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.amber,
                    backgroundImage: Image.network(
                            "https://avatars.akamai.steamstatic.com/54ebc5eecc532e7afed9498dde2132658cc1a65a_full.jpg")
                        .image,
                  ),
                  if (_isNavBarOpen) SizedBox(width: 10),
                  if (_isNavBarOpen)
                    Text(
                      "Divide By Zero",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
