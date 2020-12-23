import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'audio_paly_manager.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<AudioPlayManager>(
    create: (context) => AudioPlayManager(),
  ),
];
