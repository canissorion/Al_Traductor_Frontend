import 'package:web_translator_ml/app/app.dart';
import 'package:web_translator_ml/bootstrap.dart';
import 'package:web_translator_ml/injection.dart';

void main() {
  configureDependencies();
  bootstrap(() => const App());
}
