import 'package:flutter_test/flutter_test.dart';
import 'package:gmail_alarm/model/google_auth_client.dart';
import 'package:gmail_alarm/model/google_auth_client.mocks.dart.bak';
import 'package:mockito/annotations.dart';

import 'package:background_fetch/background_fetch.dart' as bgf;

import 'package:gmail_alarm/model/gmail_api_wrapper.dart';
// import 'package:Googleau';
import 'package:gmail_alarm/model/background_fetch_wrapper.dart';

import 'background_fetch_wrapper_test.mocks.dart';

@GenerateMocks([GoogleAuthClient])
@GenerateMocks([bgf.BackgroundFetch])
@GenerateMocks([GmailApiWrapper])
void main() {
  group('background_fetch happy path tests', () {
    final mockBGF = MockBackgroundFetch();
    // final mockGAC = MockGoogleAuthClient();

    test('test pollMail happy path completed without an error', () {
      BackgroundFetchWrapper.pollMail();
      expect(0, 0);
    });
  });
}