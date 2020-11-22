import 'package:bymyeyefe/constant/ConstantVar.dart';

class TextToSpeedService{
  static Future speak(String text) async {
    if (text != null && ConstantVar.flutterTts != null) {
      if (text.isNotEmpty) {
        await ConstantVar.flutterTts.awaitSpeakCompletion(true);
        await ConstantVar.flutterTts.speak(text);
      }
    }
  }
}