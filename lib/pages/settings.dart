import 'package:flutter/material.dart';
import 'package:frontend/pages/informacion_equipo.dart';
import 'package:frontend/pages/page_controller.dart';

class ConfigApp extends StatefulWidget {
  bool value;
  String _direccion;
  ConfigApp(this.value, this._direccion, {Key? key}) : super(key: key);

  @override
  State<ConfigApp> createState() => _ConfigAppState();
}

class _ConfigAppState extends State<ConfigApp> {
  @override
  Widget build(BuildContext context) {
    final myController = TextEditingController();
    return MaterialApp(
      home: Scaffold(
          backgroundColor: bColor(widget.value),
          appBar: bar(context, widget.value, widget._direccion),
          body: Column(
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.grey, width: 2))),
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                height: 50.0,
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: TextField(
                      controller: myController,
                      style: TextStyle(color: tColor(widget.value)),
                      textCapitalization: TextCapitalization.sentences,
                      decoration: const InputDecoration(
                        hintText: "Ruta API ej: http://10.0.2.2:5000",
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    )),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            widget._direccion = myController.text;
                          });
                        },
                        icon: const Icon(
                          Icons.send_rounded,
                          color: Colors.grey,
                        ))
                  ],
                ),
              ),
              //APIroute(widget.value, widget._direccion),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  temaTexto(widget.value),
                  const SizedBox(
                    width: 200,
                  ),
                  buildSwitch()
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [temaOpcion(widget.value)],
              ),
              const SizedBox(
                height: 20,
              ),
              infoEquipo(context, widget.value, widget._direccion)
            ],
          )),
    );
  }

  Widget buildSwitch() => Switch.adaptive(
      activeTrackColor: Colors.grey,
      inactiveTrackColor: Colors.grey,
      activeColor: Colors.black,
      inactiveThumbColor: Colors.white,
      value: widget.value,
      onChanged: (value) => setState(() => widget.value = value));
}

AppBar bar(context, value, direccion) {
  return AppBar(
    backgroundColor: bColor(value),
    title: Row(children: [
      IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TPageController(value, direccion)),
          );
        },
        icon: Icon(Icons.arrow_back_outlined, color: tColor(value)),
        iconSize: 45,
      ),
      SizedBox(
        width: 200,
        height: 50,
        child: Center(
          child: Text(
            "Configuración",
            style: TextStyle(
                color: tColor(value),
                fontFamily: 'Inter',
                fontSize: 20,
                fontWeight: FontWeight.w900),
          ),
        ),
      ),
    ]),
  );
}

Widget APIroute(value, direccion) {
  final myController = TextEditingController();
  return Container(
    decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey, width: 2))),
    padding: const EdgeInsets.symmetric(horizontal: 14.0),
    height: 50.0,
    child: Row(
      children: <Widget>[
        Expanded(
            child: TextField(
          controller: myController,
          style: TextStyle(color: tColor(value)),
          textCapitalization: TextCapitalization.sentences,
          decoration: const InputDecoration(
            hintText: "Ruta API ej: http://10.0.2.2:5000",
            hintStyle: TextStyle(color: Colors.grey),
          ),
        )),
        IconButton(
            onPressed: () {
              direccion = myController.text;
              print(direccion);
            },
            icon: const Icon(
              Icons.send_rounded,
              color: Colors.grey,
            ))
      ],
    ),
  );
}

Widget temaTexto(value) {
  return SizedBox(
    width: 100,
    height: 20,
    child: Center(
      child: Text("Tema",
          style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 20.0,
              color: tColor(value),
              fontWeight: FontWeight.bold)),
    ),
  );
}

Widget temaOpcion(value) {
  const List<String> temas = ["Claro", "Oscuro"];
  return SizedBox(
      height: 20,
      width: 100,
      child: Center(
          child: Text(
        temas[value ? 0 : 1],
        style: const TextStyle(
            fontFamily: 'Inter', fontSize: 15, color: Colors.grey),
      )));
}

Color bColor(value) {
  const List<Color> temas = [Colors.white, Color.fromARGB(255, 42, 42, 42)];
  return temas[value ? 0 : 1];
}

Color tColor(value) {
  const List<Color> temas = [Colors.black, Colors.white];
  return temas[value ? 0 : 1];
}

Widget infoEquipo(context, value, direccion) {
  return Container(
      height: 80,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Colors.grey, width: 2),
              top: BorderSide(color: Colors.grey, width: 2))),
      child: ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => InfoEquipo(value, direccion)));
        },
        title: Row(
          children: <Widget>[
            Center(child: Icon(Icons.info_outline, color: tColor(value))),
            const SizedBox(width: 10),
            Center(
                child: Text("Información",
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 18,
                        color: tColor(value),
                        fontWeight: FontWeight.bold)))
          ],
        ),
      ));
}
