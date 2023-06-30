// Flutter Packages
import 'package:dollars/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Controllers
import 'package:dollars/controllers/window_controller.dart';
// Widgets
import 'package:dollars/widgets/my_window_frame.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  @override
  void initState() {
    super.initState();

    // Window Controller
    ref.read(windowProvider.notifier).splashScreenCallback();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyWindowFrame(
        child: Container(
          child: Column(
            children: [
              Text("Login"),
              MaterialButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Home(),
                      settings: RouteSettings(name: "home.dart"),
                    ),
                  );
                },
                color: Theme.of(context).colorScheme.primary,
                child: Text("Login"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
