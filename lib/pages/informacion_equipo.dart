import 'package:flutter/material.dart';
import 'package:frontend/pages/settings.dart';

class InfoEquipo extends StatefulWidget {
  final bool value;
  final String _direccion;
  const InfoEquipo(this.value, this._direccion, {Key? key}) : super(key: key);

  @override
  State<InfoEquipo> createState() => _InfoEquipoState();
}

class _InfoEquipoState extends State<InfoEquipo> {
  List<String> a = ["Tremend", "Increible", "Epicardo"];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: bar(context, widget.value, widget._direccion),
        backgroundColor: bColor(widget.value),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 10),
              SizedBox(
                height: 20,
                child: Text(
                  "Lider de grupo",
                  style: titulo(widget.value),
                ),
              ),
              SizedBox(
                height: 15,
                child: Text(
                  "Manuel Toledo",
                  style: texto(widget.value),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 20,
                child: Text(
                  "Lideres de equipos",
                  style: titulo(widget.value),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 20,
                child: Text(
                  "Investigación",
                  style: subTitulo(widget.value),
                ),
              ),
              SizedBox(
                height: 30,
                child: Text(
                  "Javier Cisternas",
                  style: texto(widget.value),
                ),
              ),
              SizedBox(
                height: 20,
                child: Text(
                  "Documentación",
                  style: subTitulo(widget.value),
                ),
              ),
              SizedBox(
                height: 30,
                child: Text(
                  "Jennifer Portiño",
                  style: texto(widget.value),
                ),
              ),
              SizedBox(
                height: 20,
                child: Text(
                  "Desarrollo",
                  style: subTitulo(widget.value),
                ),
              ),
              SizedBox(
                height: 30,
                child: Text(
                  "Valentina Tobar",
                  style: texto(widget.value),
                ),
              ),
              SizedBox(
                height: 20,
                child: Text(
                  "Equipo de Investigación",
                  style: subTitulo(widget.value),
                ),
              ),
              SizedBox(
                child: Column(
                  children: [
                    Text(
                      "Diego Salinas",
                      style: texto(widget.value),
                    ),
                    Text(
                      "Axel Brito",
                      style: texto(widget.value),
                    ),
                    Text(
                      "Diego Tapia",
                      style: texto(widget.value),
                    ),
                    Text(
                      "Luis Correa",
                      style: texto(widget.value),
                    ),
                    Text(
                      "Luis Rivas",
                      style: texto(widget.value),
                    ),
                    Text(
                      "Luis Salinas",
                      style: texto(widget.value),
                    ),
                    Text(
                      "Paulo Vera",
                      style: texto(widget.value),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 20,
                child: Text(
                  "Equipo de Documentación",
                  style: subTitulo(widget.value),
                ),
              ),
              SizedBox(
                child: Column(
                  children: [
                    Text(
                      "Alonso Pino",
                      style: texto(widget.value),
                    ),
                    Text(
                      "Axel Jerez",
                      style: texto(widget.value),
                    ),
                    Text(
                      "Brandon Corman",
                      style: texto(widget.value),
                    ),
                    Text(
                      "Lukas Jara",
                      style: texto(widget.value),
                    ),
                    Text(
                      "Sebastián Muñoz",
                      style: texto(widget.value),
                    ),
                    Text(
                      "Esteban Tudela",
                      style: texto(widget.value),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 20,
                child: Text(
                  "Equipo de Desarrollo",
                  style: subTitulo(widget.value),
                ),
              ),
              SizedBox(
                child: Column(
                  children: [
                    Text(
                      "Carlos Montuyao",
                      style: texto(widget.value),
                    ),
                    Text(
                      "Dante Cáceres",
                      style: texto(widget.value),
                    ),
                    Text(
                      "Lukas Muñoz",
                      style: texto(widget.value),
                    ),
                    Text(
                      "Facundo Alexandre",
                      style: texto(widget.value),
                    ),
                    Text(
                      "Javier Garrido",
                      style: texto(widget.value),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

AppBar bar(context, value, direccion) {
  return AppBar(
    backgroundColor: bColor(value),
    title: Row(
      children: <Widget>[
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ConfigApp(value, direccion)),
            );
          },
          icon: Icon(Icons.arrow_back_outlined, color: tColor(value)),
          iconSize: 50,
        ),
        SizedBox(
          width: 200,
          height: 50,
          child: Center(
              child: Text(
            "Información",
            style: TextStyle(
                color: tColor(value),
                fontFamily: 'Inter',
                fontSize: 17,
                fontWeight: FontWeight.w900),
          )),
        ),
      ],
    ),
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

TextStyle titulo(value) {
  return TextStyle(
      color: tColor(value), fontSize: 18, fontWeight: FontWeight.bold);
}

TextStyle subTitulo(value) {
  return TextStyle(
      color: tColor(value), fontSize: 16, fontWeight: FontWeight.bold);
}

TextStyle texto(value) {
  return TextStyle(
      color: tColor(value), fontSize: 15, fontWeight: FontWeight.w500);
}
