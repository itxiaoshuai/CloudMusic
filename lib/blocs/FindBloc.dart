import 'dart:async';


import 'package:flutter_app/data/protocol/banner_model.dart';

import 'BlocProvider.dart';

class FindBloc implements BlocBase {
  StreamController<List<BannerModel>> _BannerStreamController =
      StreamController<List<BannerModel>>();

  get _bannerSink => _BannerStreamController.sink;

  get bannerStream => _BannerStreamController.stream;

  @override
  void dispose() {
    // TODO: implement dispose
    _BannerStreamController.close();
  }
}
