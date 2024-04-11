// ignore_for_file: use_build_context_synchronously

// Flutter Packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
// Controllers
import '/controllers/games/steam_controller.dart';
import '/controllers/anime/anime_controller.dart';
// Pages
import '/pages/profile/profile_settings/link_account/link_account.dart';
// Widgets
import '/widgets/response_widget.dart';
// Utils
import '/utils/context_extensions.dart';

class LinkDialogConnect extends ConsumerStatefulWidget {
  const LinkDialogConnect({super.key, required this.accountType});

  final LinkAccountTypes accountType;

  @override
  ConsumerState<LinkDialogConnect> createState() => _LinkDialogConnectState();
}

class _LinkDialogConnectState extends ConsumerState<LinkDialogConnect>
    with SingleTickerProviderStateMixin {
  bool hasAccepted = false, isLoading = false, isAwating = true;
  late ({String message, bool success}) connectResponse;

  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
  }

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
      LinkAccountTypes.myAnimeList => await ref.read(animeProvider.notifier).linkMALAccount(),
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
        response as ({String message, String redirectUrl, bool success});

        launchUrl(Uri.parse(response.redirectUrl));

        connectResponse = (success: response.success, message: response.message);
        setState(() => isLoading = false);

        break;
      default:
    }
  }

  Widget handleConnectTitle() {
    String service = switch (widget.accountType) {
      LinkAccountTypes.steam => "Steam",
      LinkAccountTypes.github => "Github",
      LinkAccountTypes.myAnimeList => "MyAnimeList",
    };

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Conectar sua conta ",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(
          service,
          style: TextStyle(
            color: context.colorScheme.primary,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget handleConnectLogo() {
    return switch (widget.accountType) {
      LinkAccountTypes.steam => const Icon(FontAwesomeIcons.steam, size: 80),
      LinkAccountTypes.github => const Icon(FontAwesomeIcons.github, size: 80),
      LinkAccountTypes.myAnimeList => Container(
          height: 80,
          width: 80,
          alignment: Alignment.center,
          decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          child: const Text(
            "MAL",
            style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
          ),
        )
    };
  }

  Widget createLink() => SizedBox(
        width: 100,
        child: Stack(
          children: [
            const Positioned(
              top: 4,
              bottom: 0,
              child: Text(
                "-------------------------",
                maxLines: 1,
                overflow: TextOverflow.clip,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Icon(
                  Icons.link,
                  size: 22,
                ),
              ),
            ),
          ],
        ),
      );

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Container(
        height: 400,
        width: 540,
        padding: const EdgeInsets.all(20),
        color: Colors.transparent,
        alignment: Alignment.center,
        child: !hasAccepted
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      handleConnectLogo(),
                      createLink(),
                      SvgPicture.asset(
                        "assets/images/svg_logo_white.svg",
                        height: 105,
                        width: 105,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  handleConnectTitle(),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: Text(
                      "Uma nova guia será aberta para que você possa realizar o login utilizando o método OAuth 2.0.",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: MaterialButton(
                            onPressed: () => Navigator.pop(context),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            color: Colors.grey,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                              child: Text("Cancelar"),
                            ),
                          ),
                        ),
                        const SizedBox(width: 30),
                        Expanded(
                          child: MaterialButton(
                            onPressed: handleConnect,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            color: context.colorScheme.primary,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                              child: Text("Autorizar"),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
            : isLoading
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Lottie.asset(
                          // https://lottiefiles.com/animations/rocket-animation-tailwind-blue-IN2PlyJA8M?from=search
                          "assets/lottie/rocket_loading.json",
                          controller: _controller,
                          onLoaded: (composition) {
                            _controller
                              ..duration = const Duration(seconds: 4)
                              ..repeat();
                          },
                          height: 150,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        child: const Text(
                          "Aguarde. Gerando o link...",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
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
                    : isAwating
                        ? const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.hourglass_empty,
                                size: 120,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 30),
                              Text(
                                "Aguardando login...",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 40),
                                child: Text(
                                  "O link de validação foi gerado. Faça o login na sua conta para finalizar o processo de conexão.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.verified,
                                size: 120,
                                color: Colors.green,
                              ),
                              SizedBox(height: 30),
                              Text(
                                "Conta Conectada",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 40),
                                child: Text(
                                  "Seus dados foram validados e sua conta foi conectada com sucesso!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
      ),
    );
  }
}
