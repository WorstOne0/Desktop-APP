// Flutter Packages
import 'package:dollars/services/window_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Screens
import 'posts/posts_home.dart';
// Controllers
import '../controllers/core/route_controller.dart';
// Widgets
import '/widgets/my_nav_bar.dart';
import '/widgets/my_window_frame.dart';

class WindowFramePage extends ConsumerStatefulWidget {
  const WindowFramePage({super.key});

  @override
  ConsumerState<WindowFramePage> createState() => _WindowFramePageState();
}

class _WindowFramePageState extends ConsumerState<WindowFramePage> {
  @override
  void initState() {
    super.initState();

    // Window Controller
    ref.read(windowService).homeCallback();

    asyncInit();
  }

  void asyncInit() async {
    await Future.delayed(const Duration(milliseconds: 50));

    // Update NavBar Selected
    ref.read(routeProvider.notifier).changeNavBarRoute(NavBarRoutes.HOME);
    ref.read(routeProvider.notifier).handleRouteStack("replace all", "Home");
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<NavigatorState> navigatorKey = ref.watch(routeProvider).navigatorKey;

    return Scaffold(
      body: MyWindowFrame(
        isLogin: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Row(
            children: [
              // Nav Bar
              const MyNavBar(),

              // Nested Navigator for the rest of the Screen
              Expanded(
                child: Navigator(
                  key: navigatorKey,
                  onGenerateRoute: (route) => MaterialPageRoute(
                    builder: (context) => const PostsHome(),
                    settings: route,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
