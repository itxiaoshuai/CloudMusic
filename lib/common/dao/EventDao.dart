import 'package:event_bus/event_bus.dart';
import 'package:flutter_app/common/event/LoadingEvent.dart';

class Loading{
  static final EventBus eventBus = EventBus();
  Loading.show() {
    eventBus.fire(LoadingEvent.show());
  }

  Loading.hide() {
    eventBus.fire(LoadingEvent.hide());
  }
}


