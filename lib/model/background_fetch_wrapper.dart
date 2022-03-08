//Dart imports
import 'dart:isolate';

//Flutter Core imports
import 'package:flutter/foundation.dart' as foundation;
import 'package:googleapis/accesscontextmanager/v1.dart';

//Flutter Plugin imports
import 'package:googleapis/gmail/v1.dart' as GMailLib;
import 'package:gmail_alarm/utils/gmail_app_util.dart';

//@KEN: how to ignore non-null safe code.
// ignore: import_of_legacy_library_into_null_safe
import 'package:background_fetch/background_fetch.dart';
import 'package:gmail_alarm/model/gmail_api_wrapper.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mockito/annotations.dart';

//App imports
import '../View_Model/gmail_label_view_model.dart';
import 'google_auth_client.dart';


class BackgroundFetchWrapper {
  static const String EVENTS_KEY = 'fetch_events';
  static FlutterLocalNotificationsPlugin? _flutterLocalNotificationsPlugin;
  static late GmailLabelViewModel gmailLabelViewModel;
  static final Set<GMailLib.Message> _notifiedEmails = <GMailLib.Message>{};

  static set notifier(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) {
    _flutterLocalNotificationsPlugin = flutterLocalNotificationsPlugin;
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  static Future<void> initPlatformState(GmailLabelViewModel asm) async {
    gmailLabelViewModel = asm;
    foundation.debugPrint(
        '[BackgroundFetch] initPlatformState called @ ${DateTime.now()}');

    // Configure BackgroundFetch.
    try {
      int status = await BackgroundFetch.configure(
          BackgroundFetchConfig(
            minimumFetchInterval: 15,
            forceAlarmManager: false,
            stopOnTerminate: false,
            startOnBoot: true,
            enableHeadless: true,
            requiresBatteryNotLow: false,
            requiresCharging: false,
            requiresStorageNotLow: false,
            requiresDeviceIdle: false,
            requiredNetworkType: NetworkType.ANY,
          ),
          _onBackgroundFetch,
          _onBackgroundFetchTimeout);
      print('[BackgroundFetch] configure success: $status');

      // Schedule a "one-shot" custom-task in 10000ms.
      // These are fairly reliable on Android (particularly with forceAlarmManager) but not iOS,
      // where device must be powered (and delay will be throttled by the OS).
      await BackgroundFetch.scheduleTask(TaskConfig(
          taskId: 'com.transistorsoft.customtask',
          delay: 10000,
          periodic: false,
          forceAlarmManager: true,
          stopOnTerminate: false,
          startOnBoot: true,
          enableHeadless: true));
    } catch (e) {
      foundation.debugPrint('[BackgroundFetch] configure ERROR: $e');
    }

    // TODO: Move to after runApp() in main()
    // Register to receive BackgroundFetch events after app is terminated.
    // Requires {stopOnTerminate: false, enableHeadless: true}
    // await BackgroundFetch.registerHeadlessTask(BackgroundFetchWrapper.backgroundFetchHeadlessTask);
  } // initPlatformState

  static void _onBackgroundFetch(String taskId) async {
    foundation.debugPrint(
        '[BackgroundFetch] _onBackgroundFetch called @ ${DateTime.now()} with taskId:$taskId');
    await pollMail();
    if (taskId == 'flutter_background_fetch') {
      // Schedule a one-shot task when fetch event received (for testing).
      await BackgroundFetch.scheduleTask(TaskConfig(
          taskId: 'com.transistorsoft.customtask',
          delay: 5000,
          periodic: false,
          forceAlarmManager: true,
          stopOnTerminate: false,
          startOnBoot: true,
          enableHeadless: true,
          requiresNetworkConnectivity: true,
          requiresCharging: true));
    }
    // IMPORTANT:  You must signal completion of your fetch task or the OS can punish your app for taking too long in the background.
    BackgroundFetch.finish(taskId);
  } //_onBackgroundFetch

  /// This event fires shortly before your task is about to timeout.  You must finish any outstanding work and call BackgroundFetch.finish(taskId).
  static void _onBackgroundFetchTimeout(String taskId) {
    print('[BackgroundFetch] TIMEOUT: $taskId');
    BackgroundFetch.finish(taskId);
  }

  /// This "Headless Task" is run when app is terminated.
  static void backgroundFetchHeadlessTask(HeadlessTask task) async {
    showStateNotification('backgroundFetchHeadlessTask called');
    foundation.debugPrint(
        '[BackgroundFetch] backgroundFetchHeadlessTask called @ ${DateTime.now()}, taskId:${task.taskId}');
    String taskId = task.taskId;
    bool timeout = task.timeout;
    if (timeout) {
      foundation
          .debugPrint('[BackgroundFetch] Headless task timed-out: $taskId');
      BackgroundFetch.finish(taskId);
      return;
    }
    await pollMail();
    if (taskId == 'flutter_background_fetch') {
      await BackgroundFetch.scheduleTask(TaskConfig(
          taskId: 'com.transistorsoft.customtask',
          delay: 5000,
          periodic: false,
          forceAlarmManager: false,
          stopOnTerminate: false,
          startOnBoot: true,
          enableHeadless: true));
    }
    BackgroundFetch.finish(taskId);
  }

  static void scheduleTask() async {
    try {
      // Schedule a "one-shot" custom-task in 10000ms.
      // These are fairly reliable on Android (particularly with forceAlarmManager) but not iOS,
      // where device must be powered (and delay will be throttled by the OS).
      await BackgroundFetch.scheduleTask(TaskConfig(
          taskId: 'com.transistorsoft.customtask',
          delay: 1000,
          periodic: false,
          forceAlarmManager: true,
          stopOnTerminate: false,
          startOnBoot: true,
          enableHeadless: true));
    } catch (e) {
      foundation.debugPrint('[BackgroundFetch] configure ERROR: $e');
    }
  }

  static Future<void> pollMail() async {
    foundation.debugPrint('[pollMail]: pollMail called');

    final gmailApi = GmailApiWrapper(
        client: GoogleAuthClient(statusDisplayCallBack: showStateNotification)
            ..instance);
    if (gmailLabelViewModel == null) {
      showStateNotification('Unable to query emails, restart the app');
      return;
    }
    if (gmailLabelViewModel.savedLabels.isEmpty) {
      foundation.debugPrint('appStateModel.savedLabels is null');
    }

    //for multiple labels: {label:label1 label:label2-label21}
    var savedLabels = '';
    var mailSummery = <String, int>{};
    if (gmailLabelViewModel.savedLabels.isNotEmpty) {
      gmailLabelViewModel.savedLabels.forEach((element) {
        savedLabels += 'label:$element ';
      });

      try {
        List<GMailLib.Message> messagesResponse =
            await gmailApi.messagesByLabels(savedLabels);

        if (messagesResponse.isEmpty) {
          foundation.debugPrint('[pollMail]: Empty Messages');
        } else {
          foundation
              .debugPrint('[pollMail]: Num of Msg ${messagesResponse.length}');

          for (GMailLib.Message message in messagesResponse) {
            //Message: message = {historyId = null,id = "17964bec9fb40da0",internalDate = null,labelIds = null,payload = null,raw = null,sizeEstimate = null,snippet = null,threadId = "17964bec9fb40da0"}
            foundation.debugPrint('[pollMail]: message.id:${message.id}');
            if (!_notifiedEmails.contains(message)) {
              _notifiedEmails.add(message);
              var realMsg = await gmailApi.messageById(message.id!);
              foundation.debugPrint('[pollMail]: realMsg:${realMsg}');

              var headers = realMsg.payload!.headers;
              foundation
                  .debugPrint('[pollMail]: num headers: ${headers!.length}');
              headers.forEach((GMailLib.MessagePartHeader mph) {
                if (mph.name == 'From') {
                  if (mailSummery.containsKey(mph.value)) {
                    mailSummery[mph.value!] = mailSummery[mph.value]! + 1;
                  } else {
                    mailSummery[mph.value!] = 1;
                  }
                }
              });
            } else {
              foundation.debugPrint(
                  '[pollMail]: skipping notification for already notified message.id:${message.id}');
            }
          }
          if (mailSummery.isNotEmpty) {
            _showGroupedNotifications(mailSummery);
            gmailLabelViewModel.alarmOn = true;
            GMailAppUtil.playAlarm();
          }
        }
      } on DetailedApiRequestError catch (e) {
        mailSummery["Error:" + e.message!] = e.status!;
        _showGroupedNotifications(mailSummery);
      }
    }
  }

  static void _showNotification(Map<String, int> mailSummery) async {
    String body = '';
    mailSummery.forEach((key, value) {
      body += key + '(' + value.toString() + '),\n';
    });
    //ignore: omit_local_variable_types
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    //ignore: omit_local_variable_types
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    foundation.debugPrint('body: $body');
    await _flutterLocalNotificationsPlugin!.show(
        0, 'New Emails', body, platformChannelSpecifics,
        payload: 'item x');
  }

  static void _showGroupedNotifications(Map<String, int> mailSummery) {
    //ignore: omit_local_variable_types
    const String groupKey = 'com.android.example.gmail_alarm_key';
    const String groupChannelId = 'gmail_alarm_grouped channel id';
    const String groupChannelName = 'gmail_alarm_grouped channel name';
    const String groupChannelDescription = 'gmail_alarm_grouped channel description';
    // example based on https://developer.android.com/training/notify-user/group.html
    int index = 0;
    mailSummery.forEach((key, value) {
      const AndroidNotificationDetails notificationAndroidSpecifics =
          AndroidNotificationDetails(
              groupChannelId, groupChannelName, groupChannelDescription,
              importance: Importance.max,
              priority: Priority.high,
              groupKey: groupKey);

      const NotificationDetails notificationPlatformSpecifics =
          NotificationDetails(android: notificationAndroidSpecifics);
      _flutterLocalNotificationsPlugin!
          .show(index, key, '($value)', notificationPlatformSpecifics);
      index++;
    }); //mailSummery.forEach
  }

  static void showStateNotification(String message) async {
    foundation.debugPrint('[background_fetch_wrapper] message:$message');
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'state_notification channel id',
      'state_notification channel name',
      'state_notification channel description',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    //ignore: omit_local_variable_types
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    if (_flutterLocalNotificationsPlugin != null) {
      await _flutterLocalNotificationsPlugin!.show(
          0, 'gmail_alarm', message, platformChannelSpecifics,
          payload: 'item x');
    }
  }
}
