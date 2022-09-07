import 'dart:convert';
import 'package:frontend/models/modelos.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:frontend/pages/settings.dart';
import 'package:frontend/widgets/mensajes.dart';

class TextTranslate extends StatefulWidget {
  final bool value;
  final String _direccion;
  TextTranslate(this.value, this._direccion, {Key? key}) : super(key: key);

  @override
  State<TextTranslate> createState() => _TextTranslateState();
}

class _TextTranslateState extends State<TextTranslate> {
  String? currentValue = '  Español-Mapudungún';
  final myController = TextEditingController();
  bool mapudungun = false;
  final List<Message> _mensajes = [];

  @override
  void dispose() {
    // Limpia el controlador cuando el Widget se descarte
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String temp;
    return MaterialApp(
        home: Scaffold(
      backgroundColor: bColor(widget.value),
      appBar: bar(context, widget.value, widget._direccion),
      body: Scaffold(
        backgroundColor: bColor(widget.value),
        appBar: AppBar(
          backgroundColor: bColor(widget.value),
          elevation: 0,
          title: Center(
              child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 147, 147, 147).withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                  color: const Color.fromARGB(255, 147, 147, 147),
                  style: BorderStyle.solid,
                  width: 0.80),
            ),
            height: 50,
            width: 250,
            child: DropdownButtonFormField(
              hint: const Text("   Seleccionar idioma"),
              items: <String>['  Español-Mapudungún', '  Inglés-Español']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? valueIn) {
                setState(() {
                  currentValue = valueIn;
                  if (currentValue == '  Español-Mapudungún') {
                    mapudungun = true;
                  } else {
                    mapudungun = false;
                  }
                });
              },
              iconEnabledColor: const Color.fromARGB(255, 0, 152, 80),
              iconDisabledColor: const Color.fromARGB(255, 0, 152, 80),
              iconSize: 50,
            ),
          )),
        ),
        body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: SizedBox(
                    child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        ),
                        child: Mensajes(
                          mensajes: _mensajes,
                          textoInicial:
                              "Envia cualquier frase para empezar a traducir",
                          speaker: mapudungun,
                          direccion: widget._direccion,
                        )),
                  ),
                ),
                Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        height: 50.0,
                        color: const Color.fromARGB(255, 217, 217, 217),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: TextField(
                              controller: myController,
                              style: const TextStyle(color: Colors.black),
                              textCapitalization: TextCapitalization.sentences,
                              decoration: const InputDecoration(
                                hintText: "Escribe frase para traducir",
                                hintStyle: TextStyle(color: Colors.black),
                              ),
                            )),
                            IconButton(
                                onPressed: () async {
                                  temp = myController.text.toLowerCase();
                                  String traducido = await conectar(
                                      currentValue, temp, widget._direccion);
                                  setState(() {
                                    _mensajes.insert(0, Message(temp, true));
                                    _mensajes.insert(
                                        0, Message(traducido, false));
                                    myController.text = "";
                                  });
                                },
                                icon: const Icon(
                                  Icons.send_rounded,
                                  color: Color.fromARGB(255, 0, 152, 80),
                                ))
                          ],
                        ),
                      ),
                    )),
              ],
            )),
      ),
    ));
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
        },
        body: body);
    return utf8.decode(response.bodyBytes);
  }
}

AppBar bar(context, value, direccion) {
  return AppBar(
    backgroundColor: bColor(value),
    title: Text(
      "Texto",
      style: TextStyle(
          color: tColor(value),
          fontFamily: 'Inter',
          fontSize: 20,
          fontWeight: FontWeight.w900),
    ),
    actions: [
      IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ConfigApp(value, direccion)),
          );
        },
        icon: const Icon(Icons.settings,
            color: Color.fromARGB(255, 115, 115, 115)),
        iconSize: 40,
      )
    ],
  );
}

Color bColor(value) {
  const List<Color> temas = [Colors.white, Color.fromARGB(255, 42, 42, 42)];
  return temas[value ? 0 : 1];
}

Color tColor(value) {
  const List<Color> temas = [Colors.black, Colors.white];
  return temas[value ? 0 : 1];
}
