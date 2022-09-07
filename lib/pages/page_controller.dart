import 'package:flutter/material.dart';
import 'package:frontend/pages/text_translate.dart';
import 'package:frontend/pages/voice_translate.dart';

class TPageController extends StatefulWidget {
  final bool value;
  final String _direccion;
  const TPageController(this.value, this._direccion, {Key? key})
      : super(key: key);

  @override
  State<TPageController> createState() => _TPageControllerState();
}

class _TPageControllerState extends State<TPageController> {
  int _actualpage = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      TextTranslate(widget.value, widget._direccion),
      VoiceTranslate(widget.value, widget._direccion)
    ];
    return MaterialApp(
      home: Scaffold(
        body: pages[_actualpage],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: bColor(widget.value),
          onTap: (index) {
            setState(() {
              _actualpage = index;
            });
          },
          currentIndex: _actualpage,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.chat_outlined), label: "Texto a Texto"),
            BottomNavigationBarItem(
                icon: Icon(Icons.mic_outlined), label: "Voz a Voz")
          ],
        ),
      ),
    );
  }
}

Color bColor(value) {
  const List<Color> temas = [Colors.white, Color.fromARGB(255, 42, 42, 42)];
  return temas[value ? 0 : 1];
}
