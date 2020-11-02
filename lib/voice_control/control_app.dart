import 'package:alan_voice/alan_voice.dart';
import 'package:bymyeyefe/layout/mainLayout.dart';
import 'package:flutter/cupertino.dart';

class ControlApp extends StatefulWidget {
  @override
  _ControlAppState createState() => _ControlAppState();
}

class _ControlAppState extends State<ControlApp> {
  @override
  Widget build(BuildContext context) {
    return MainLayOut.getMailLayout(context, widget, "USER", "VOICE CONTROL");
  }

  _ControlAppState() {
    AlanVoice.addButton(
        "157ff59dff366a1596ffbf23c9dd7be92e956eca572e1d8b807a3e2338fdd0dc/stage",
        buttonAlign: AlanVoice.BUTTON_ALIGN_LEFT);
    AlanVoice.callbacks.add((command) => _handleCommand(command.data["data"]));
    AlanVoice.addConnectionCallback((newState) => _handelConnectionState());
  }

  void _handleCommand(Map command) {
    debugPrint("New command: ${command}");
    switch (command["command"]) {
      default:
        debugPrint("Unknown command: ${command}");
    }
  }

  _handelConnectionState() {

  }
}
