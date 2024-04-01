// ignore_for_file: constant_identifier_names

// Flutter Packages
import 'package:dollars/models/core/user/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart';
// Controllers
import 'user_controller.dart';
// Pages
import '/pages/splash_screen.dart';
// Services
import '/services/navigator_provider.dart';
import '/services/apis/api_provider.dart';
import '/services/storage/secure_storage.dart';
// Widgets
import '/widgets/my_snackbar.dart';

// My Controller are a mix between the Controller and Repository from the
// Riverpod Architecture (https://codewithandrea.com/articles/flutter-app-architecture-riverpod-introduction/).
// It handles the management of the widget state. (Riverpod Controller's job)
// It handles the data parsing and serialilzation from api's. (Riverpod Repository's job).

enum SocketConnection { CONNECTED, DISCONNECTED }

@immutable
class SocketIOState {
  const SocketIOState({
    required this.socketStatus,
    required this.socketId,
    required this.message,
  });

  final SocketConnection socketStatus;
  final String socketId;
  final String message;

  SocketIOState copyWith({SocketConnection? socketStatus, String? socketId, String? message}) {
    return SocketIOState(
      socketStatus: socketStatus ?? this.socketStatus,
      socketId: socketId ?? this.socketId,
      message: message ?? this.message,
    );
  }
}

class SocketIOController extends StateNotifier<SocketIOState> {
  SocketIOController({required this.ref, required this.apiProvider})
      : super(
          const SocketIOState(
            socketStatus: SocketConnection.DISCONNECTED,
            socketId: "",
            message: "Socket ainda não conectado",
          ),
        );

  Ref ref;

  ApiProvider apiProvider;
  SecureStorage storage = SecureStorage();

  late Socket socket;

  String baseUrl = baseUrlOnEnviroment(APIEnviroment.LOCAL);

  // Connect to the back and set the handler for each event
  Future<({bool success, String message})> connectAndListen() async {
    try {
      socket = io(
        baseUrl,
        OptionBuilder().setPath("/socket_server").setTransports(['websocket']).build(),
      );

      // On Connect
      socket.onConnect(
        (_) => state = state.copyWith(
          socketStatus: SocketConnection.CONNECTED,
          socketId: socket.id,
          message: "Socket conectado com sucesso!",
        ),
      );
      socket.onConnecting((data) => state = state.copyWith(message: "Realizando conexão..."));
      socket.onConnectError((data) => state = state.copyWith(message: data.toString()));
      // On Reconnect
      socket.onReconnect(
        (data) => state = state.copyWith(
          socketStatus: SocketConnection.CONNECTED,
          socketId: socket.id,
          message: "Socket reconectado com sucesso!",
        ),
      );
      socket.onReconnecting((data) => state = state.copyWith(message: "Tentando reconectar..."));
      socket.onReconnectError((data) => state = state.copyWith(message: data.toString()));

      // On disconnect
      socket.onDisconnect(
        (_) => state = state.copyWith(
          socketStatus: SocketConnection.DISCONNECTED,
          message: "Socket disconectado!",
        ),
      );

      // Events
      socket.on('auth_relog', authRelog);
      socket.on('auth_reload_page', authReloadPage);

      return (success: true, message: "");
    } catch (error) {
      return (success: false, message: error.toString());
    }
  }

  void addHandler(String event, Function(dynamic) handler) => socket.on(event, handler);
  // Sends an event to the Back
  void emitToBack(String event, dynamic data) => socket.emit(event, data);
  // Enters and leaves the Rooms
  void handleRoom(bool isEntering, String room) {
    socket.emit(isEntering ? "join_room" : "leave_room", room);
  }

  // *** Events ***
  void authRelog(dynamic data) {
    User? user = ref.read(userProvider).user;
    if (user != null) emitToBack("set_user", user.id);
  }

  void authReloadPage(dynamic data) async {
    ScaffoldMessenger.of(ref.read(navigatorKeyProvider).currentContext!)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        mySnackBar(
          Colors.red,
          Icons.error,
          "Suas permissões de usuário foram alteradas, o sistema será recarregado em 5 segundos.",
          maxLines: 3,
          duration: const Duration(seconds: 5),
          behavior: SnackBarBehavior.fixed,
        ),
      );

    await Future.delayed(const Duration(seconds: 5));
    Get.offAll(() => const SplashScreen());
  }
}

final socketIOProvider = StateNotifierProvider<SocketIOController, SocketIOState>((ref) {
  return SocketIOController(
    ref: ref,
    apiProvider: ref.watch(apiProvider),
  );
});
