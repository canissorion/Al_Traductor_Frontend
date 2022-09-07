abstract class Listamensajes {}

// Modelo de mensajes para desplegarlos en la app
class Message implements Listamensajes {
  final String body;
  final bool isMe;
  Message(this.body, this.isMe);
}
