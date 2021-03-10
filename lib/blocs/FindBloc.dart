import 'dart:async';

import 'package:cloud_music/data/protocol/banner_model.dart';

import 'BlocProvider.dart';

class FindBloc implements BlocBase {
  StreamController<List<BannerModel>> _bannerStreamController =
      StreamController<List<BannerModel>>();

  get _bannerSink => _bannerStreamController.sink;

  get bannerStream => _bannerStreamController.stream;

  @override
  void dispose() {
    // TODO: implement dispose
    _bannerStreamController.close();
  }
}
