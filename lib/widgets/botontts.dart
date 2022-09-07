import 'dart:async';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BotonTTS extends StatefulWidget {
  final String texto;
  final bool autoplay;
  final bool speaker;
  final String direccion;

  const BotonTTS(
      {Key? key,
      required this.texto,
      required this.autoplay,
      required this.speaker,
      required this.direccion})
      : super(key: key);

  @override
  _BotonTTSState createState() => _BotonTTSState();
}

class _BotonTTSState extends State<BotonTTS> {
  bool _autoplayDone = false;

  FlutterTts flutterTts = FlutterTts();

  Future _configs() async {
    await flutterTts.setLanguage("es-CL");
  }

  Future _speak(texto) async {
    if (widget.speaker) {
      mapudungun();
    } else {
      await _configs();
      await flutterTts.speak(texto);
    }
  }

  Future<void> _init() async {
    if (widget.autoplay && !(_autoplayDone)) {
      _speak(widget.texto);
      _autoplayDone = true;
    }
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void didUpdateWidget(BotonTTS oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.autoplay && (widget.texto != oldWidget.texto)) {
      _speak(widget.texto);
    }
  }

  Future mapudungun() async {
    String url = "${widget.direccion}/translator/ttsmap";
    var connect = Uri.parse(url);
    Map data = {"text": widget.texto};
    var body = jsonEncode(data);
    var response = await http.post(connect,
        headers: {
          "Content-Type": "application/json; charset=utf-8",
          "Accept": "*/*",
        },
        body: body);
    var temp = response.body;
    if (temp.length > 10) {
      temp = temp.replaceAll("[", '');
      temp = temp.replaceAll("]", '');
      temp = temp.replaceAll('"', '');
      temp = temp.replaceAll(' ', '');
      final rutas = temp.split(",");
      for (int i = 0; i < rutas.length; i++) {
        final assetsAudioPlayer = AssetsAudioPlayer();
        String aux = rutas[i];
        aux = aux.substring(1);
        if (i == rutas.length - 1) {
          aux = aux.substring(0, aux.length - 2);
        }
        try {
          assetsAudioPlayer.open(
            Audio(aux),
          );
        } catch (e) {
          print("Error: $e");
        }
        await Future.delayed(const Duration(milliseconds: 300));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return (IconButton(
      icon: const Icon(Icons.play_circle_outline),
      tooltip: 'Escuchar',
      color: Colors.black,
      onPressed: () {
        _speak(widget.texto);
      },
    ));
  }
}
