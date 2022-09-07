import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'botontts.dart';

class Mensaje extends StatefulWidget {
  final String texto;
  final bool isMe;
  final bool autoplay;
  final bool speaker;
  final String direccion;
  const Mensaje(
      {Key? key,
      required this.texto,
      required this.isMe,
      required this.autoplay,
      required this.speaker,
      required this.direccion})
      : super(key: key);

  @override
  _MensajeState createState() => _MensajeState();
}

class _MensajeState extends State<Mensaje> {
  @override
  Widget build(BuildContext context) {
    return (Bubble(
        margin: widget.isMe
            ? const BubbleEdges.only(top: 10, bottom: 10)
            : const BubbleEdges.only(top: 10, bottom: 10),
        alignment: widget.isMe ? Alignment.topRight : Alignment.topLeft,
        nip: widget.isMe ? BubbleNip.rightTop : BubbleNip.leftTop,
        color: widget.isMe
            ? Theme.of(context).colorScheme.secondary
            : const Color(0xFFFFEFEE),
        child: Row(children: <Widget>[
          Flexible(
            child:
                Text(widget.texto, style: const TextStyle(color: Colors.black)),
          ),
          if (!(widget.isMe))
            BotonTTS(
              texto: widget.texto,
              autoplay: widget.autoplay,
              speaker: widget.speaker,
              direccion: widget.direccion,
            )
        ])));
  }
}
