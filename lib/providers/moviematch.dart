// Code is here: https://pastebin.com/x5sChMiL

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';

import '../generated/moviematch.pbgrpc.dart';

class MovieMatchProvider extends ChangeNotifier {
  late final ClientChannel _channel;
  late final MovieMatchClient _stub;
  late final StreamController<StateMessage> _send;
  late final ResponseStream<StateMessage> _receive;

  MovieMatchProvider() {
    var isAndroid = Platform.isAndroid;

    String baseUrl = isAndroid ? '10.0.2.2' : "localhost";

    _channel = ClientChannel(
      baseUrl, // This is android emulator's proxy to localhost on host machine
      port: 50051,
      options: ChannelOptions(credentials: ChannelCredentials.insecure()),
    );

    _stub = MovieMatchClient(_channel);
    _send = StreamController<StateMessage>();
    _receive = _stub.streamState(_send.stream);

    _receive.listen((msg) {
      print("message: ${msg.user}: ${msg.data}");
    });
  }

  void send() {
    var msg =
        StateMessage()
          ..data = "test"
          ..user = "client";

    _send.add(msg);
  }
}
