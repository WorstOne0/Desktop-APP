// Flutter Packages
import 'package:flutter/material.dart';

class ProfileHome extends StatefulWidget {
  const ProfileHome({super.key});

  @override
  State<ProfileHome> createState() => _ProfileHomeState();
}

class _ProfileHomeState extends State<ProfileHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => ListView(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          children: [
            Container(
              height: 700,
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: Image.network(
                          "https://www.pixel4k.com/wp-content/uploads/2019/11/cyberpunk-city_1574940837.jpg")
                      .image,
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
                    child: Card(
                      elevation: 2,
                      child: Container(
                        height: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
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
                          "https://avatars.akamai.steamstatic.com/54ebc5eecc532e7afed9498dde2132658cc1a65a_full.jpg",
                          fit: BoxFit.cover,
                        ).image,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
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
                SizedBox(width: 20),
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
