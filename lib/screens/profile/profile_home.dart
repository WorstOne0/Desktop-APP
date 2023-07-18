// Flutter Packages
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
                    "https://www.pixel4k.com/wp-content/uploads/2019/11/cyberpunk-city_1574940837.jpg",
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
                        child: Container(
                          height: 300,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Upper
                              Container(
                                height: 120,
                                child: Row(
                                  children: [
                                    // Left
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.topCenter,
                                        padding: EdgeInsets.all(20),
                                        child: Row(
                                          children: [
                                            IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                FontAwesomeIcons.steam,
                                                color: Color(0xFF171a21),
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                FontAwesomeIcons.discord,
                                                color: Color(0xFF7289da),
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                FontAwesomeIcons.teamspeak,
                                                color: Color(0xFF2580c3),
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                FontAwesomeIcons.instagram,
                                                color: Color(0xFFE1306C),
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {},
                                              icon: Icon(
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
                                        padding: EdgeInsets.all(20),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                true
                                                    ? FontAwesomeIcons.heart
                                                    : FontAwesomeIcons.solidHeart,
                                                color: true ? null : Colors.red,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {},
                                              icon: Icon(
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
                                padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: Container(
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
                                                  style: TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                Icon(
                                                  Icons.verified,
                                                  color: Colors.blue,
                                                )
                                              ],
                                            ),
                                            Text(
                                              "@${user.userName}",
                                              style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
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
                                    Expanded(
                                      child: Container(
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
                        backgroundColor: Colors.amber,
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
                Card(
                  elevation: 2,
                  child: Container(
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
          onPressed: () {},
          label: Row(
            children: [
              Icon(Icons.edit),
              SizedBox(width: 5),
              Text("Editar Perfil"),
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
