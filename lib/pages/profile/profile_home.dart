// Flutter Packages
import 'package:dollars/controllers/route_controller.dart';
import 'package:dollars/pages/profile/profile_settings/profile_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dollars/controllers/user_controller.dart';
import 'package:dollars/models/user/user.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileHome extends ConsumerStatefulWidget {
  const ProfileHome({super.key});

  @override
  ConsumerState<ProfileHome> createState() => _ProfileHomeState();
}

class _ProfileHomeState extends ConsumerState<ProfileHome> {
  @override
  Widget build(BuildContext context) {
    User user = ref.watch(userProvider).user!;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => ListView(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          children: [
            Container(
              height: 800,
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: Image.network(
                    "https://wallpapers.com/images/hd/foggy-mountain-minimalist-1s0w3a4nti5bvzw7.webp",
                  ).image,
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // User Info Area
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: ClipPath(
                      clipper: MyCustomClipper(),
                      child: Card(
                        elevation: 2,
                        child: SizedBox(
                          height: 300,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Upper
                              SizedBox(
                                height: 120,
                                child: Row(
                                  children: [
                                    // Left
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.topCenter,
                                        padding: const EdgeInsets.all(20),
                                        child: Row(
                                          children: [
                                            IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                FontAwesomeIcons.steam,
                                                color: Color(0xFF171a21),
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                FontAwesomeIcons.discord,
                                                color: Color(0xFF7289da),
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                FontAwesomeIcons.teamspeak,
                                                color: Color(0xFF2580c3),
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                FontAwesomeIcons.instagram,
                                                color: Color(0xFFE1306C),
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                FontAwesomeIcons.reddit,
                                                color: Color(0xFFFF5700),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    // Useless Area
                                    const SizedBox(
                                      height: 120,
                                      width: 220,
                                    ),

                                    // Right
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.topCenter,
                                        padding: const EdgeInsets.all(20),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                true
                                                    ? FontAwesomeIcons.heart
                                                    : FontAwesomeIcons.solidHeart,
                                                color: true ? null : Colors.red,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                true ? Icons.person_add : Icons.group,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Lower
                              Expanded(
                                  child: Container(
                                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Expanded(
                                      child: Row(
                                        children: [
                                          Icon(Icons.calendar_month),
                                          SizedBox(width: 10),
                                          Text(
                                            "Member since Jun, 2023",
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  user.screenName,
                                                  style: const TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                const Icon(
                                                  Icons.verified,
                                                  color: Colors.blue,
                                                )
                                              ],
                                            ),
                                            Text(
                                              "@${user.userName}",
                                              style: const TextStyle(
                                                fontStyle: FontStyle.italic,
                                              ),
                                            )
                                          ],
                                        ),
                                        const Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.description),
                                                SizedBox(width: 5),
                                                Text("20")
                                              ],
                                            ),
                                            SizedBox(width: 25),
                                            Row(
                                              children: [
                                                Icon(Icons.groups_2),
                                                SizedBox(width: 5),
                                                Text("20")
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const Expanded(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Icon(Icons.flag),
                                          SizedBox(width: 10),
                                          Text(
                                            "Brasil, Paraná",
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    bottom: -160,
                    child: Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 100,
                        backgroundImage: Image.network(
                          // "https://avatars.akamai.steamstatic.com/54ebc5eecc532e7afed9498dde2132658cc1a65a_full.jpg",
                          user.profilePicture ?? "",
                          fit: BoxFit.cover,
                        ).image,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 15),
            Card(
              elevation: 2,
              child: Container(
                height: 170,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.squareSteam,
                            size: 48,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          Text(
                            "360",
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Jogos na Steam",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 0.5,
                      color: Colors.grey,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.timer,
                            size: 48,
                            color: Colors.cyan,
                          ),
                          Text(
                            "3.450h",
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Horas Jogadas",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 0.5,
                      color: Colors.grey,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.dove,
                            size: 48,
                            color: Colors.orange,
                          ),
                          Text(
                            "Aguia 2",
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "CS GO",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 0.5,
                      color: Colors.grey,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.skull,
                            size: 48,
                            color: Colors.red,
                          ),
                          Text(
                            "860",
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Tarkov Kills",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Card(
                    elevation: 2,
                    child: Container(
                      height: 1000,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                const Card(
                  elevation: 2,
                  child: SizedBox(
                    height: 1000,
                    width: 300,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // Change NavBar Route
            ref.read(routeProvider).navigatorKey.currentState!.push(
                  MaterialPageRoute(
                    builder: (context) => const ProfileSettings(),
                    settings: const RouteSettings(name: "profile_settings.dart"),
                  ),
                );

            // Update NavBar Selected
            ref.read(routeProvider.notifier).handleRouteStack("push", "Settings");
          },
          label: const Row(
            children: [
              Icon(Icons.settings),
              SizedBox(width: 5),
              Text("Configurações"),
            ],
          )),
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    final paint = Paint();
    paint.color = Colors.transparent;

    Path path = Path.combine(
      PathOperation.difference,
      Path()
        ..addRRect(
          RRect.fromRectAndCorners(
            Rect.fromLTWH(0, 0, size.width, 300),
            topLeft: const Radius.circular(8),
            bottomLeft: const Radius.circular(8),
            bottomRight: const Radius.circular(8),
            topRight: const Radius.circular(8),
          ),
        ),
      Path()
        ..addOval(Rect.fromCircle(center: Offset(size.width / 2, 0), radius: 110))
        ..close(),
    );

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return false;
  }
}
