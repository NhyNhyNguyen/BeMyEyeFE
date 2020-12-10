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
    ConstantVar.flutterTts.setLanguage(ConstantVar.currentLocal);
  }

}