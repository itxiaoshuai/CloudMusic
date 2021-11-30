import 'dart:async';


import 'package:cloud_music/data/protocol/BannerBean.dart';

import 'BlocProvider.dart';

class FindBloc implements BlocBase {
  StreamController<List<BannerBean>> _bannerStreamController =
      StreamController<List<BannerBean>>();

  // get _bannerSink => _bannerStreamController.sink;

  get bannerStream => _bannerStreamController.stream;

  @override
  void dispose() {
    // TODO: implement dispose
    _bannerStreamController.close();
  }
}
