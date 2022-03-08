// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// import 'dart:isolate';

import 'dart:async';
import 'dart:collection';

import 'package:get_it/get_it.dart';
import 'package:gmail_alarm/model/ad_state.dart';
import 'package:googleapis/gmail/v1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mockito/annotations.dart';

import 'package:gmail_alarm/utils/locator.dart';
import 'package:gmail_alarm/base/base_model.dart';
import 'package:gmail_alarm/View_Model/settings_view_model.dart';

import 'package:gmail_alarm/model/gmail_api_wrapper.dart';
import '../utils/gmail_app_util.dart';
import '../model/background_fetch_wrapper.dart';


abstract class GmailLabelViewModelIF {
  AdState? get adState;
  void set adState(AdState? adState);
  bool get alarmOn;
  void set alarmOn(bool isOn);
  List<String> get labels;
  get numberOfLabels;
  Set<String> get savedLabels;
  void addLabelToFavs(String label_name);
  bool alreadySaved(String label);
  void clearLabels();
  String labelAt(int i);
  Future<void> loadLabels();
  Future<void> loadSavedLabels();
  void removeLabelFromFavs(String label_name);
  void saveLabels();
}

// @GenerateMocks([GmailLabelViewModel])
class GmailLabelViewModel extends BaseModel implements GmailLabelViewModelIF {
  final Map<String,Label> _gmailLabels = HashMap<String,Label>();
  List<String> _gmailLabelNames = [];
  Set<String> _savedLabels = {};
  Set<String> get savedLabels => _savedLabels;
  AdState? _adState = null;

  bool get alarmOn {
    var settingsModel = locator<SettingsViewModel>();
    return settingsModel.alarmOn;
  }

  set alarmOn(bool isOn) {
    var settingsModel = locator<SettingsViewModel>();
    settingsModel.alarmOn = isOn;
    notifyListeners();
  }

  AdState? get adState => _adState;
  void set adState(AdState? adState) => _adState = adState;

  // var gmailApiWrapper;
  // AppStateModel({@visibleForTesting dynamic mockGoogleAuthClient}) {
  // GmailLabelViewModel({dynamic gmailApiWrapper}) {
  //   this.gmailApiWrapper = gmailApiWrapper != null ? gmailApiWrapper : GmailApiWrapper();
  // }
  // ===
  GmailLabelViewModel() {}


  List<String> get labels => _gmailLabelNames;

  int get numberOfLabels => _gmailLabelNames.length;

  String labelAt(int i) => _gmailLabelNames[i];

  void clearLabels() { _savedLabels = {}; _gmailLabelNames = []; _gmailLabels.clear(); }

  bool alreadySaved(String label) {
    return _savedLabels.contains(label);
  }

  void addLabelToFavs(String label_name) {
    _savedLabels.add(label_name);
    saveLabels();
    notifyListeners();
    BackgroundFetchWrapper.scheduleTask();
  }

  void removeLabelFromFavs(String label_name) {
    _savedLabels.remove(label_name);
    saveLabels();
    notifyListeners();
  }

  void saveLabels() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(GMailAppUtil.SAVED_LABELS, _savedLabels.join(','));
  }

  Future<void> loadLabels() async {
    // var gmailApiWrapper = locater<GmailApiWrapperIF>();
    var gmailApiWrapper = GetIt.instance<GmailApiWrapperIF>();
    List<Label> labels = await gmailApiWrapper.labels();
    for (Label label in labels) {
      _gmailLabels[label.name!] = label;
    }
    _gmailLabelNames = _gmailLabels.keys.toList(growable: false)..sort();
    await loadSavedLabels();
    exception = null;
    notifyListeners();
  }

  Future<void> loadSavedLabels() async {
    List<String> savedLabels = await GMailAppUtil.loadSavedLabels();
    _savedLabels = Set.from(savedLabels);
  }
}
