import 'package:flutter/material.dart';
import 'package:gmail_alarm/base/base_model.dart';


class SettingsViewModel extends BaseModel {
  bool _alarmOn = false;
  bool get alarmOn => _alarmOn;
  set alarmOn(bool alarmState) {
    _alarmOn = alarmState;
    notifyListeners();
  }
}