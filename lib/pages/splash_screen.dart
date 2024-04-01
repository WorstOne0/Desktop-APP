// ignore_for_file: use_build_context_synchronously

// Flutter packages
import 'package:dollars/services/window_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
// Screens
import 'auth/login.dart';
// Controllers

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // Window Controller
    ref.read(windowService).splashScreenCallback();

    _controller = AnimationController(vsync: this);

    asyncInit();
  }

  void asyncInit() async {
    // After durations time changes page
    await Future.delayed(const Duration(seconds: 5));

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Login(),
        settings: RouteSettings(
          name: "login.dart",
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.network(
            "https://assets10.lottiefiles.com/packages/lf20_wfkxpgpa.json",
            controller: _controller,
            onLoaded: (composition) {
              _controller
                ..duration = const Duration(seconds: 4)
                ..repeat();
            },
            height: width * 0.5,
          ),
          Text(
            "Lendo Dados...",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    ));
  }
}
