import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/modelos.dart';
import 'mensaje.dart';

class Mensajes extends StatefulWidget {
  final String textoInicial;
  final List<Message> mensajes;
  final bool speaker;
  final String direccion;

  const Mensajes(
      {Key? key,
      required this.textoInicial,
      required this.mensajes,
      required this.speaker,
      required this.direccion})
      : super(key: key);

  @override
  _MensajesState createState() => _MensajesState();
}

class _MensajesState extends State<Mensajes> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      padding: const EdgeInsets.only(top: 15.0, bottom: 10),
      itemCount: widget.mensajes.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == widget.mensajes.length) {
          return Bubble(
            alignment: Alignment.center,
            color: const Color.fromRGBO(212, 234, 244, 1.0),
            child: Text(widget.textoInicial,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black)),
          );
        } else {
          final Message message = widget.mensajes[index];
          return Mensaje(
            texto: message.body,
            isMe: message.isMe,
            autoplay: (index == 0),
            speaker: widget.speaker,
            direccion: widget.direccion,
          );
        }
      },
    );
  }
}
