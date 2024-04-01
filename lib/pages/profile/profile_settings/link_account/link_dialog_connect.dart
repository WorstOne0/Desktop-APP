// ignore_for_file: use_build_context_synchronously

// Flutter Packages

import 'package:dollars/controllers/games/steam_controller.dart';
import 'package:dollars/pages/profile/profile_settings/link_account/link_account.dart';
import 'package:dollars/utils/context_extensions.dart';
import 'package:dollars/widgets/response_widget.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dollars/controllers/core/route_controller.dart';
import 'package:dollars/widgets/my_tab_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkDialogConnect extends ConsumerStatefulWidget {
  const LinkDialogConnect({super.key, required this.accountType});

  final LinkAccountTypes accountType;

  @override
  ConsumerState<LinkDialogConnect> createState() => _LinkDialogConnectState();
}

class _LinkDialogConnectState extends ConsumerState<LinkDialogConnect> {
  bool hasAccepted = false, isLoading = false;
  late ({String message, bool success}) connectResponse;

  void handleConnect() async {
    setState(() {
      hasAccepted = true;
      isLoading = true;
    });

    var response = switch (widget.accountType) {
      LinkAccountTypes.steam => await ref.read(steamProvider.notifier).linkSteamAccount(),
      LinkAccountTypes.github => (
          success: false,
          message: "Não foi implementado ainda cara. Da um tempo pra nois aew"
        ),
      LinkAccountTypes.myAnimeList => (
          success: false,
          message: "Não foi implementado ainda cara. Da um tempo pra nois aew"
        ),
    };

    switch (widget.accountType) {
      case LinkAccountTypes.steam:
        response as ({String message, String redirectUrl, bool success});

        launchUrl(Uri.parse(response.redirectUrl));

        connectResponse = (success: response.success, message: response.message);
        setState(() => isLoading = false);

        break;
      case LinkAccountTypes.github:
        response as ({String message, bool success});

        connectResponse = response;
        setState(() => isLoading = false);

        break;
      case LinkAccountTypes.myAnimeList:
        response as ({String message, bool success});

        connectResponse = response;
        setState(() => isLoading = false);

        break;
      default:
    }
  }

  Widget handleConnectTitle() {
    return Text(
      switch (widget.accountType) {
        LinkAccountTypes.steam => "Conectar sua conta Steam",
        LinkAccountTypes.github => "Conectar sua conta Github",
        LinkAccountTypes.myAnimeList => "Conectar sua conta MyAnimeList",
      },
      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    );
  }

  Widget handleConnectLogo() {
    return switch (widget.accountType) {
      LinkAccountTypes.steam => const Icon(FontAwesomeIcons.steam, size: 60),
      LinkAccountTypes.github => const Icon(FontAwesomeIcons.github, size: 60),
      LinkAccountTypes.myAnimeList => const Padding(
          padding: EdgeInsets.symmetric(vertical: 6),
          child: Text(
            "MAL",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        )
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: 500,
      alignment: Alignment.center,
      child: !hasAccepted
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    handleConnectLogo(),
                    Container(
                      padding: const EdgeInsets.all(5),
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Icon(
                        Icons.link,
                        size: 18,
                      ),
                    ),
                    Icon(FontAwesomeIcons.dev, size: 60)
                  ],
                ),
                SizedBox(height: 20),
                handleConnectTitle(),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Text(
                    "Será aberto uma nova guia para ser realizado o login, OAuth2.0 e etc e talz",
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      onPressed: () => Navigator.pop(context),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      color: Colors.grey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                        child: Text("Cancelar"),
                      ),
                    ),
                    SizedBox(width: 30),
                    MaterialButton(
                      onPressed: handleConnect,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      color: context.colorScheme.primary,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                        child: Text("Autorizar"),
                      ),
                    )
                  ],
                )
              ],
            )
          : isLoading
              ? const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: CircularProgressIndicator(),
                    ),
                    SizedBox(height: 30),
                    Text(
                      "Aguarde ...",
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                )
              : !connectResponse.success
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: ResponseWidget(
                        icon: Icons.error,
                        iconColor: Colors.red,
                        title: "Erro ao conectar conta",
                        subtitle: connectResponse.message,
                      ),
                    )
                  : Column(
                      children: [
                        Icon(Icons.timer),
                        Text(
                            "Mano preguiça. Aqui e pra colocar q o login vai abrir no navegador e dps tu volta aki")
                      ],
                    ),
    );
  }
}
