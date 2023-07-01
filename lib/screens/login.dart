// Flutter Packages
import 'package:dollars/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Controllers
import 'package:dollars/controllers/window_controller.dart';
// Widgets
import 'package:dollars/widgets/my_window_frame.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();

    // Window Controller
    ref.read(windowProvider.notifier).loginCallback();
  }

  void handleLogin() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const Home(),
        settings: const RouteSettings(name: "home.dart"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyWindowFrame(
        child: Padding(
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
                              Icon(
                                Icons.logo_dev,
                                size: 60,
                              ),
                              Container(
                                padding: EdgeInsets.only(bottom: 5),
                                child: const Text(
                                  "DOLLARS",
                                  style: TextStyle(fontSize: 40, letterSpacing: 15, height: 0.9),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
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
                          SizedBox(height: 10),
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
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(""),
                                MaterialButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Esqueceu sua Senha?",
                                    style: TextStyle(color: Colors.grey, height: 0.9),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: MaterialButton(
                              onPressed: handleLogin,
                              height: 55,
                              minWidth: double.infinity,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              color: Theme.of(context).colorScheme.primary,
                              child: const Text("Login"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {},
                      child: Text(
                        "Aplicar para a WhiteList!",
                        style: TextStyle(color: Colors.grey, height: 0.9),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(width: 20),
              Card(
                elevation: 2,
                child: Container(
                  height: 450,
                  width: 300,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
