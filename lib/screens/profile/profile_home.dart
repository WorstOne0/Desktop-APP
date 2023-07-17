// Flutter Packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dollars/controllers/user_controller.dart';
import 'package:dollars/models/user/user.dart';

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
              height: 700,
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
                              Container(
                                height: 120,
                                child: Row(
                                  children: [],
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              user.screenName,
                                              style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              "@${user.userName}",
                                              style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    )
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
                    bottom: -60,
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
                Expanded(
                  child: Card(
                    elevation: 2,
                    child: Container(
                      height: 1000,
                    ),
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
