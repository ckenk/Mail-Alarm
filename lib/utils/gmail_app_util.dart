import 'package:gmail_alarm/View_Model/settings_view_model.dart';
import 'package:gmail_alarm/utils/locator.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
// import 'package:gmail_alarm/model/gmail_label_view_model.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// mocks:  flutter pub run build_runner build --delete-conflicting-outputs
@GenerateMocks([GMailAppUtil])
class GMailAppUtil {
  static final SAVED_LABELS = "saved_labels";
  static SettingsViewModel settings_model = locator<SettingsViewModel>();

  static void playAlarm() {
    FlutterRingtonePlayer.playAlarm(asAlarm: true);
  }

  static void stopAlarm() {
    FlutterRingtonePlayer.stop();
  }

  static Future<List<String>> loadSavedLabels() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? text = await prefs.getString(GMailAppUtil.SAVED_LABELS);
    var labels = <String>[];
    if (text != null) {
      for (String label_name in text.split(',')) {
        labels.add(label_name);
      }
    }
    return labels;
  }

  static Future<void> deleteSavedLabels() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(GMailAppUtil.SAVED_LABELS);
  }

  static void switchOnChange({bool value = false}) {
    if(settings_model.alarmOn) stopAlarm();
    if(!settings_model.alarmOn) playAlarm();
    settings_model.alarmOn = value;
  }
}



