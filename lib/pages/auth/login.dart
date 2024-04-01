// ignore_for_file: use_build_context_synchronously

// Flutter Packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Screens
import '../window_frame_page.dart';
// Controllers
import '../../controllers/core/user_controller.dart';
// Service
import '/services/window_service.dart';
// Widgets
import '/widgets/my_snackbar.dart';
import '/widgets/my_window_frame.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  bool isLoading = true, isPasswordVisible = false;

  final _userController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Window Controller
    ref.read(windowService).loginCallback();

    checkIsLogged();
  }

  void checkIsLogged() async {
    var isLogged = await ref.read(userProvider.notifier).isLogged();

    print(isLogged);
    if (isLogged.success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const WindowFramePage(),
          settings: const RouteSettings(name: "window_frame_page.dart"),
        ),
      );
    }

    setState(() => isLoading = false);
  }

  void handleLogin() async {
    if (isLoading) return;

    setState(() => isLoading = true);

    var response = await ref.read(userProvider.notifier).login(
      {
        "email": _userController.text,
        "password": _passwordController.text,
      },
    );

    if (response.success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const WindowFramePage(),
          settings: const RouteSettings(name: "window_frame_page.dart"),
        ),
      );

      return;
    }

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        mySnackBar(
          Colors.red,
          Icons.error,
          response.message,
          duration: const Duration(seconds: 5),
        ),
      );

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyWindowFrame(
        isLogin: true,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Image.asset("assets/images/space_background.png").image,
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.logo_dev,
                                size: 60,
                              ),
                              Container(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: const Text(
                                  "DOLLARS",
                                  style: TextStyle(fontSize: 40, letterSpacing: 15, height: 0.9),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Card(
                            elevation: 2,
                            child: TextFormField(
                              controller: _userController,
                              maxLines: 1,
                              decoration: InputDecoration(
                                isDense: true,
                                labelText: "Usuario",
                                labelStyle: const TextStyle(
                                  color: Colors.white,
                                ),
                                suffixIcon: Icon(
                                  Icons.email,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 24,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: Colors.transparent),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      BorderSide(color: Theme.of(context).colorScheme.primary),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Card(
                            elevation: 2,
                            child: TextFormField(
                              controller: _passwordController,
                              maxLines: 1,
                              obscureText: true,
                              decoration: InputDecoration(
                                isDense: true,
                                labelText: "Senha",
                                labelStyle: const TextStyle(
                                  color: Colors.white,
                                ),
                                suffixIcon: Icon(
                                  Icons.password,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 24,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: Colors.transparent),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      BorderSide(color: Theme.of(context).colorScheme.primary),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 20,
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(""),
                                MaterialButton(
                                  onPressed: () {},
                                  child: const Text(
                                    "Esqueceu sua Senha?",
                                    style: TextStyle(color: Colors.grey, height: 0.9),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: MaterialButton(
                              onPressed: handleLogin,
                              height: 55,
                              minWidth: double.infinity,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              color: Theme.of(context).colorScheme.primary,
                              child: isLoading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(),
                                    )
                                  : const Text("Login"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {},
                      child: const Text(
                        "Aplicar para a WhiteList!",
                        style: TextStyle(color: Colors.grey, height: 0.9),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Container(
                height: 450,
                width: 300,
              )
            ],
          ),
        ),
      ),
    );
  }
}
