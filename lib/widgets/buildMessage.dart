// ignore_for_file: file_names
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class BuildMessage extends StatefulWidget {
  final TextEditingController _mycontroller;
  final String? _state;
  final String _direccion;
  BuildMessage(this._mycontroller, this._state, this._direccion, {Key? key})
      : super(key: key);

  @override
  State<BuildMessage> createState() => _BuildMessageState();
}

class _BuildMessageState extends State<BuildMessage> {
  @override
  Widget build(BuildContext context) {
    String? temp;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      height: 50.0,
      color: const Color.fromARGB(255, 217, 217, 217),
      child: Row(
        children: <Widget>[
          Expanded(
              child: TextField(
            controller: widget._mycontroller,
            style: const TextStyle(color: Colors.black),
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(
              hintText: "Escribe frase para traducir",
              hintStyle: TextStyle(color: Colors.black),
            ),
          )),
          IconButton(
              onPressed: () async {
                temp = widget._mycontroller.text;
                Future<String?> traducido =
                    conectar(widget._state, temp, widget._direccion);
              },
              icon: const Icon(
                Icons.send_rounded,
                color: Color.fromARGB(255, 0, 152, 80),
              ))
        ],
      ),
    );
  }

  Future<String> conectar(state, text, direccion) async {
    const List<String> url = ["/translator/espmap", "/translator/ingesp"];
    String actual = direccion + url[1];
    if (state == '  Español-Mapudungún') {
      actual = direccion + url[0];
    }
    var connect = Uri.parse(actual);
    Map data = {"text": text};
    var body = jsonEncode(data);
    var response = await http.post(connect,
        headers: {
          "Content-Type": "application/json; charset=utf-8",
          "Accept": "*/*",
          "Accept-Encoding": "gzip, deflate,br"
        },
        body: body);
    return utf8.decode(response.bodyBytes);
  }
}
