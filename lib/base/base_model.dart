
import 'package:flutter/foundation.dart';
import 'package:gmail_alarm/utils/view_state.dart';

class BaseModel with ChangeNotifier {
  ViewState _state = ViewState.Idle;
  ViewState get state => _state;
  Exception? exception = null;

  set state(ViewState viewState) {
    print('State:$viewState');
    _state = viewState;
    notifyListeners();
  }

  void update() {
    notifyListeners();
  }
}
