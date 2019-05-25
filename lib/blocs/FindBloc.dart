import 'dart:async';

import 'BlocProvider.dart';

class FindBloc implements BlocBase {
  StreamController<int> _BannerStreamController = StreamController<int>();

  get _bannerSink => _BannerStreamController.sink;

  get bannerStream => _BannerStreamController.stream;

  @override
  void dispose() {
    // TODO: implement dispose
    _BannerStreamController.close();
  }
}
