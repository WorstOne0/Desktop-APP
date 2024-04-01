// ignore_for_file: use_build_context_synchronously

// Flutter Packages

import 'package:dollars/controllers/games/steam_controller.dart';
import 'package:dollars/pages/profile/profile_settings/link_account/link_dialog_connect.dart';
import 'package:dollars/utils/context_extensions.dart';
import 'package:dollars/widgets/loading_shimmer.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dollars/controllers/core/route_controller.dart';
import 'package:dollars/widgets/my_tab_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

enum LinkAccountTypes { steam, myAnimeList, github }

class LinkAccount extends ConsumerStatefulWidget {
  const LinkAccount({super.key});

  @override
  ConsumerState<LinkAccount> createState() => _LinkAccountState();
}

class _LinkAccountState extends ConsumerState<LinkAccount> {
  bool isLoading = true, isSuccess = false;
  late ({bool success, String message}) response;

  String? steamUsername, malUsername, githubUsername;

  @override
  void initState() {
    super.initState();

    asyncInit();
  }

  void asyncInit() async {
    var responses = await Future.wait([ref.read(steamProvider.notifier).getSteamAccount()]);

    bool success = responses.every((element) => element.success);

    if (!success) {
      response = responses.firstWhere((element) => !element.success);
    }

    steamUsername = ref.read(steamProvider).steamAccountLink?.displayName;

    setState(() => isLoading = false);
  }

  void handleConnectAccount(LinkAccountTypes accountType) async {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: LinkDialogConnect(accountType: accountType),
      ),
    );
  }

  void handleDisconnectAccount(LinkAccountTypes accountType) async {
    if (isLoading) return;

    setState(() => isLoading = true);

    switch (accountType) {
      case LinkAccountTypes.steam:
        response = await ref.read(steamProvider.notifier).unlinkSteamAccount();

        break;
      default:
    }

    asyncInit();
  }

  Widget buildCard(LinkAccountTypes accountType, String? displayName) {
    bool isConnected = displayName != null;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            switch (isConnected) {
              true => const Icon(Icons.link, color: Colors.green),
              false => const Icon(Icons.link_off, color: Colors.red),
            },
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 30),
                  Card(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: context.colorScheme.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: switch (accountType) {
                        LinkAccountTypes.steam => const Icon(FontAwesomeIcons.steam, size: 32),
                        LinkAccountTypes.github => const Icon(FontAwesomeIcons.github, size: 32),
                        LinkAccountTypes.myAnimeList => const Padding(
                            padding: EdgeInsets.symmetric(vertical: 6),
                            child: Text(
                              "MAL",
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          )
                      },
                    ),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        switch (accountType) {
                          LinkAccountTypes.steam => "Steam",
                          LinkAccountTypes.github => "Github",
                          LinkAccountTypes.myAnimeList => "MyAnimeList",
                        },
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        switch (accountType) {
                          LinkAccountTypes.steam => isConnected
                              ? "Conectado como $displayName"
                              : "Conecte sua conta da Steam",
                          LinkAccountTypes.github =>
                            isConnected ? "Github" : "Conecte sua conta do Github",
                          LinkAccountTypes.myAnimeList =>
                            isConnected ? "My Anime List" : "Conecte sua conta do MyAnimeList",
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
            MaterialButton(
              onPressed: () => displayName != null
                  ? handleDisconnectAccount(accountType)
                  : handleConnectAccount(accountType),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              color: displayName != null ? Colors.red : context.colorScheme.primary,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                child: Text(
                  displayName != null ? "Disconectar" : "Conectar",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const accountTypeList = LinkAccountTypes.values;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => Card(
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    "Conexões",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 15),
                isLoading
                    ? Column(
                        children: [
                          rectLoadingCard(120),
                          SizedBox(height: 15),
                          rectLoadingCard(120),
                          SizedBox(height: 15),
                          rectLoadingCard(120),
                          SizedBox(height: 15),
                          rectLoadingCard(120),
                          SizedBox(height: 15),
                        ],
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: accountTypeList.length,
                          itemBuilder: (context, index) => buildCard(
                            accountTypeList[index],
                            switch (accountTypeList[index]) {
                              LinkAccountTypes.steam => steamUsername,
                              LinkAccountTypes.github => githubUsername,
                              LinkAccountTypes.myAnimeList => malUsername,
                            },
                          ),
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
