// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:gmail_alarm/View_Model/gmail_label_view_model.dart';
import 'package:gmail_alarm/View_Model/settings_view_model.dart';
import 'package:gmail_alarm/model/gmail_api_wrapper.dart';
import 'package:gmail_alarm/model/google_auth_client.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:gmail_alarm/settings_screen.dart';

import 'settings_screen_widget_test.mocks.dart';

// import 'background_fetch_wrapper_test.mocks.dart';


@GenerateMocks([GmailLabelViewModelIF])
@GenerateMocks([GmailApiWrapperIF])
@GenerateMocks([GoogleAuthClientIF])
void main() {
  group('settings screen', () {

    SettingsViewModel settingsViewModel = SettingsViewModel();

    var mockGmailLabelViewModel = MockGmailLabelViewModelIF();
    var mockGmailApiWrapper = MockGmailApiWrapperIF();
    var mockGoogleAuthClient = MockGoogleAuthClientIF();

    when(mockGoogleAuthClient.logout()).thenReturn(null);
    when(mockGmailLabelViewModel.adState).thenReturn(null);
    when(mockGmailLabelViewModel.clearLabels());

    GetIt locator = GetIt.instance;

    locator.registerFactory<GmailLabelViewModelIF>(() => mockGmailLabelViewModel);

    locator.registerFactory<GmailApiWrapperIF>(() => mockGmailApiWrapper);

    locator.registerFactory<GoogleAuthClientIF>(() => mockGoogleAuthClient);

    locator.registerFactory<SettingsViewModel>(() => settingsViewModel);

    // Define a test. The TestWidgets function also provides a WidgetTester
    // to work with. The WidgetTester allows you to build and interact
    // with widgets in the test environment.
    testWidgets('MyWidget has a title and message', (WidgetTester tester) async {
      var testWidget = MaterialApp(home: SettingsScreen());
      await tester.pumpWidget(testWidget);
      final buttonLogOut = find.text('Alarm');
      tester.tap(buttonLogOut);
      assert(verify(mockGmailLabelViewModel).callCount == 2);
    });
  });
}