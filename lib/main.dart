import 'dart:io';

import 'package:bymyeyefe/constant/ConstantVar.dart';
import 'package:bymyeyefe/screens/call_video/login_screen.dart';
import 'package:bymyeyefe/screens/tutorial/ChooseTypeUser.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'screens/call_video//utils/configs.dart' as config;
import 'package:connectycube_sdk/connectycube_sdk.dart';


Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    ConstantVar.cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error: $e.code\nError Message: $e.message');
  }
  runApp(new App());
}
class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AppState();
  }
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChooseTypeUser(),
    );
  }

  @override
  void initState() {
    super.initState();
    init(
      config.APP_ID,
      config.AUTH_KEY,
      config.AUTH_SECRET,
    );
    initTts();
  }

  initTts() {
    ConstantVar.flutterTts = FlutterTts();

    if (!kIsWeb) {
      if (Platform.isAndroid) {
        _getEngines();
      }
    }
    ConstantVar.flutterTts.setLanguage(ConstantVar.currentLocal);
  }


  Future _getEngines() async {
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
