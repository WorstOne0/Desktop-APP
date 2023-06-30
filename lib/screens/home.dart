// Flutter Packages
import 'package:dollars/controllers/steam_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Controllers
import 'package:dollars/controllers/window_controller.dart';
// Widgets
import 'package:dollars/widgets/my_window_frame.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  void initState() {
    super.initState();

    // Window Controller
    ref.read(windowProvider.notifier).homeCallback();

    ref.read(steamProvider.notifier).getSteamData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyWindowFrame(
        child: Container(
          child: Text("Home"),
        ),
      ),
    );
  }
}
