import 'dart:math';

import 'package:bymyeyefe/constant/ConstantVar.dart';
import 'package:bymyeyefe/screens/User/LoginScreen.dart';
import 'package:bymyeyefe/screens/User/SignUpScreen.dart';
import 'package:bymyeyefe/screens/call_video/call_screen.dart';
import 'package:bymyeyefe/screens/home_page/HomePage.dart';
import 'package:bymyeyefe/screens/tutorial/ChooseTypeUser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _hasSpeech = false;
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastWords = "";
  String lastError = "";
  String lastStatus = "";
  String _currentLocaleId = "vi_VN";
  bool hasStart = false;
  final SpeechToText speech = SpeechToText();

  @override
  void initState() {
    super.initState();
    initSpeechState();
  }

  Future<void> initSpeechState() async {
    bool hasSpeech = await speech.initialize(
        onError: errorListener, onStatus: statusListener);
    if (hasSpeech) {
      await speech.locales();
      await speech.systemLocale();
    }

    if (!mounted) return;

    setState(() {
      _hasSpeech = hasSpeech;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
//      Container(
//        child: Text(
//          lastWords,
//          textAlign: TextAlign.center,
//        ),
//      ),
      Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                blurRadius: .26,
                spreadRadius: level * 1.5,
                color: Colors.white.withOpacity(.05))
          ],
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        child: IconButton(icon: Icon(
          Icons.mic, size: 30, color: hasStart ? Colors.red : Colors.black,),
          onPressed: () =>
          {
            start()
          },),
      ),
      SizedBox(height: 5,)
    ]);
  }

  void start() {
    print("start listen");
    if (!hasStart) {
      startListening();
    } else {
      stopListening();
    }
  }

  void startListening() {
    lastWords = "";
    lastError = "";
    speech.listen(
        onResult: resultListener,
        listenFor: Duration(seconds: 7),
        localeId: _currentLocaleId,
        onSoundLevelChange: soundLevelListener,
        cancelOnError: true,
        listenMode: ListenMode.confirmation);
    setState(() {
      hasStart = true;
    });
  }

  void stopListening() {
    print("stop listen");
    speech.stop();
    setState(() {
      level = 0.0;
      hasStart = false;
    });
  }

  void cancelListening() {
    speech.cancel();
    setState(() {
      level = 0.0;
    });
  }

  void resultListener(SpeechRecognitionResult result) {
    setState(() {
      lastWords = "${result.recognizedWords} - ${result.finalResult}";
      print(lastWords);
    });
    redirect(result.recognizedWords.toLowerCase());
  }

  void redirect(String comman) {
    switch (comman.toLowerCase()) {
      case "gọi điện":
      case "call":
        _startCall();
        break;
      case "tắt gọi":
        break;
      case "chấp nhận":
        break;
      case "từ chối":
        break;
      case "đăng nhập":
      case "sign in":
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    LoginScreen()
            )
        );
        break;
      case "sign up":
      case "đăng ký":
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SignUpScreen()
            )
        );
        break;
    }
  }

  void _startCall() async {
    if (ConstantVar.currentUser != null) {
      ConstantVar.currentCall =
      await ConstantVar.callClient.createCallSession(
          ConstantVar.currentUser.id);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ConversationCallScreen(
                  ConstantVar.currentCall,
                  ConstantVar.currentUser.id.toString(),
                  [], false),
        ),
      );
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  LoginScreen()
          )
      );
    }
  }

  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    // print("sound level $level: $minSoundLevel - $maxSoundLevel ");
    setState(() {
      this.level = level;
    });
  }

  void errorListener(SpeechRecognitionError error) {
    // print("Received error status: $error, listening: ${speech.isListening}");
    setState(() {
      lastError = "${error.errorMsg} - ${error.permanent}";
    });
  }

  void statusListener(String status) {
    // print(
    // "Received listener status: $status, listening: ${speech.isListening}");
    setState(() {
      lastStatus = "$status";
    });
  }
}
