//
// Generated file. Do not edit.
//

import 'package:audioplayers/audioplayers_web.dart';
import 'package:shared_preferences_web/shared_preferences_web.dart';
import 'package:video_player_web/video_player_web.dart';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

// ignore: public_member_api_docs
void registerPlugins(Registrar registrar) {
  AudioplayersPlugin.registerWith(registrar);
  SharedPreferencesPlugin.registerWith(registrar);
  VideoPlayerPlugin.registerWith(registrar);
  registrar.registerMessageHandler();
}
