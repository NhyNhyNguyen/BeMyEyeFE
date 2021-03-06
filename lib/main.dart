import 'package:bymyeyefe/constant/ConstantVar.dart';
import 'package:bymyeyefe/screens/tutorial/ChooseTypeUser.dart';
import 'package:bymyeyefe/services/text_to_speed_service.dart';
import 'package:camera/camera.dart';
import 'package:connectycube_sdk/connectycube_sdk.dart';
import 'package:flutter/material.dart';

import 'screens/call_video//utils/configs.dart' as config;

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
    TextToSpeedService.initTts();
    initStorage();
  }

  initStorage() async {
//    await ConstantVar.storage.ready;
//    await ConstantVar.getData();
//    await ConstantVar.getUserData();
  }
}
