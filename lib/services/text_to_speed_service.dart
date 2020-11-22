import 'dart:io';

import 'package:bymyeyefe/constant/ConstantVar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeedService{
  static Future speak(String text) async {
    if (text != null && ConstantVar.flutterTts != null) {
      if (text.isNotEmpty) {
        await ConstantVar.flutterTts.awaitSpeakCompletion(true);
        await ConstantVar.flutterTts.speak(text);
      }
    }
  }

  static initTts() {
    ConstantVar.flutterTts = FlutterTts();

    if (!kIsWeb) {
      if (Platform.isAndroid) {
        _getEngines();
      }
    }
    ConstantVar.flutterTts.setLanguage(ConstantVar.currentLocal);
  }

  static Future _getEngines() async {
    var engines = await ConstantVar.flutterTts.getEngines;
    if (engines != null) {
      for (dynamic engine in engines) {
        print(engine);
      }
    }
    await ConstantVar.flutterTts.setVolume(ConstantVar.volume);
    await ConstantVar.flutterTts.setSpeechRate(ConstantVar.rate);
    await ConstantVar.flutterTts.setPitch(ConstantVar.pitch);
  }
}