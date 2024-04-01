// Flutter Packages
import 'package:dollars/controllers/core/route_controller.dart';
import 'package:dollars/pages/profile/profile_settings/link_account/link_account.dart';
import 'package:dollars/widgets/my_tab_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileSettings extends ConsumerStatefulWidget {
  const ProfileSettings({super.key});

  @override
  ConsumerState<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends ConsumerState<ProfileSettings>
    with SingleTickerProviderStateMixin {
  // Tabs
  late TabController _tabController;
  int currentTab = 0;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(
      () => setState(() {
        currentTab = _tabController.index;
      }),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 800,
                    child: Card(
                      elevation: 2,
                      child: MyTabBar(
                        items: const [
                          (icon: Icons.person, text: "Perfil"),
                          (icon: Icons.security, text: "Segurança"),
                          (icon: Icons.link, text: "Conexões")
                        ],
                        indexSelected: currentTab,
                        onTap: (value) {
                          currentTab = value;

                          setState(() {});
                          _tabController.animateTo(value);
                        },
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          ref.read(routeProvider).navigatorKey.currentState!.pop();

                          ref.read(routeProvider.notifier).handleRouteStack("pop", "");
                        },
                        icon: Row(
                          children: [
                            Text(
                              "Fechar",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 10),
                            Icon(Icons.close),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      )
                    ],
                  )
                ],
              ),
              Expanded(
                child: switch (currentTab) {
                  0 => Text("Perfil"),
                  1 => Text("Segurança"),
                  2 => LinkAccount(),
                  _ => Text("")
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
