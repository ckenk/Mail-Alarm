// Mocks generated by Mockito 5.0.16 from annotations
// in gmail_alarm/test/google_auth_client_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i9;
import 'dart:convert' as _i10;
import 'dart:typed_data' as _i11;

import 'package:firebase_auth/firebase_auth.dart' as _i6;
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart'
    as _i5;
import 'package:firebase_core/firebase_core.dart' as _i4;
import 'package:google_sign_in/google_sign_in.dart' as _i7;
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart'
    as _i13;
import 'package:http/src/base_request.dart' as _i12;
import 'package:http/src/client.dart' as _i8;
import 'package:http/src/response.dart' as _i2;
import 'package:http/src/streamed_response.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeResponse_0 extends _i1.Fake implements _i2.Response {}

class _FakeStreamedResponse_1 extends _i1.Fake implements _i3.StreamedResponse {
}

class _FakeFirebaseApp_2 extends _i1.Fake implements _i4.FirebaseApp {}

class _FakeActionCodeInfo_3 extends _i1.Fake implements _i5.ActionCodeInfo {}

class _FakeUserCredential_4 extends _i1.Fake implements _i6.UserCredential {}

class _FakeConfirmationResult_5 extends _i1.Fake
    implements _i6.ConfirmationResult {}

class _FakeUserMetadata_6 extends _i1.Fake implements _i5.UserMetadata {}

class _FakeIdTokenResult_7 extends _i1.Fake implements _i5.IdTokenResult {}

class _FakeUser_8 extends _i1.Fake implements _i6.User {}

class _FakeGoogleSignInAuthentication_9 extends _i1.Fake
    implements _i7.GoogleSignInAuthentication {}

/// A class which mocks [Client].
///
/// See the documentation for Mockito's code generation for more information.
class MockClient extends _i1.Mock implements _i8.Client {
  MockClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<_i2.Response> head(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#head, [url], {#headers: headers}),
              returnValue: Future<_i2.Response>.value(_FakeResponse_0()))
          as _i9.Future<_i2.Response>);
  @override
  _i9.Future<_i2.Response> get(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#get, [url], {#headers: headers}),
              returnValue: Future<_i2.Response>.value(_FakeResponse_0()))
          as _i9.Future<_i2.Response>);
  @override
  _i9.Future<_i2.Response> post(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i10.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#post, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i2.Response>.value(_FakeResponse_0()))
          as _i9.Future<_i2.Response>);
  @override
  _i9.Future<_i2.Response> put(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i10.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#put, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i2.Response>.value(_FakeResponse_0()))
          as _i9.Future<_i2.Response>);
  @override
  _i9.Future<_i2.Response> patch(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i10.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#patch, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i2.Response>.value(_FakeResponse_0()))
          as _i9.Future<_i2.Response>);
  @override
  _i9.Future<_i2.Response> delete(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i10.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#delete, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i2.Response>.value(_FakeResponse_0()))
          as _i9.Future<_i2.Response>);
  @override
  _i9.Future<String> read(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#read, [url], {#headers: headers}),
          returnValue: Future<String>.value('')) as _i9.Future<String>);
  @override
  _i9.Future<_i11.Uint8List> readBytes(Uri? url,
          {Map<String, String>? headers}) =>
      (super.noSuchMethod(
              Invocation.method(#readBytes, [url], {#headers: headers}),
              returnValue: Future<_i11.Uint8List>.value(_i11.Uint8List(0)))
          as _i9.Future<_i11.Uint8List>);
  @override
  _i9.Future<_i3.StreamedResponse> send(_i12.BaseRequest? request) =>
      (super.noSuchMethod(Invocation.method(#send, [request]),
              returnValue:
                  Future<_i3.StreamedResponse>.value(_FakeStreamedResponse_1()))
          as _i9.Future<_i3.StreamedResponse>);
  @override
  void close() => super.noSuchMethod(Invocation.method(#close, []),
      returnValueForMissingStub: null);
  @override
  String toString() => super.toString();
}

/// A class which mocks [AuthCredential].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthCredential extends _i1.Mock implements _i5.AuthCredential {
  MockAuthCredential() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get providerId =>
      (super.noSuchMethod(Invocation.getter(#providerId), returnValue: '')
          as String);
  @override
  String get signInMethod =>
      (super.noSuchMethod(Invocation.getter(#signInMethod), returnValue: '')
          as String);
  @override
  Map<String, dynamic> asMap() =>
      (super.noSuchMethod(Invocation.method(#asMap, []),
          returnValue: <String, dynamic>{}) as Map<String, dynamic>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [FirebaseAuth].
///
/// See the documentation for Mockito's code generation for more information.
class MockFirebaseAuth extends _i1.Mock implements _i6.FirebaseAuth {
  MockFirebaseAuth() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.FirebaseApp get app => (super.noSuchMethod(Invocation.getter(#app),
      returnValue: _FakeFirebaseApp_2()) as _i4.FirebaseApp);
  @override
  set app(_i4.FirebaseApp? _app) =>
      super.noSuchMethod(Invocation.setter(#app, _app),
          returnValueForMissingStub: null);
  @override
  set tenantId(String? tenantId) =>
      super.noSuchMethod(Invocation.setter(#tenantId, tenantId),
          returnValueForMissingStub: null);
  @override
  Map<dynamic, dynamic> get pluginConstants =>
      (super.noSuchMethod(Invocation.getter(#pluginConstants),
          returnValue: <dynamic, dynamic>{}) as Map<dynamic, dynamic>);
  @override
  _i9.Future<void> useEmulator(String? origin) =>
      (super.noSuchMethod(Invocation.method(#useEmulator, [origin]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i9.Future<void>);
  @override
  _i9.Future<void> useAuthEmulator(String? host, int? port) =>
      (super.noSuchMethod(Invocation.method(#useAuthEmulator, [host, port]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i9.Future<void>);
  @override
  _i9.Future<void> applyActionCode(String? code) =>
      (super.noSuchMethod(Invocation.method(#applyActionCode, [code]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i9.Future<void>);
  @override
  _i9.Future<_i5.ActionCodeInfo> checkActionCode(String? code) =>
      (super.noSuchMethod(Invocation.method(#checkActionCode, [code]),
              returnValue:
                  Future<_i5.ActionCodeInfo>.value(_FakeActionCodeInfo_3()))
          as _i9.Future<_i5.ActionCodeInfo>);
  @override
  _i9.Future<void> confirmPasswordReset({String? code, String? newPassword}) =>
      (super.noSuchMethod(
          Invocation.method(#confirmPasswordReset, [],
              {#code: code, #newPassword: newPassword}),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i9.Future<void>);
  @override
  _i9.Future<_i6.UserCredential> createUserWithEmailAndPassword(
          {String? email, String? password}) =>
      (super.noSuchMethod(
              Invocation.method(#createUserWithEmailAndPassword, [],
                  {#email: email, #password: password}),
              returnValue:
                  Future<_i6.UserCredential>.value(_FakeUserCredential_4()))
          as _i9.Future<_i6.UserCredential>);
  @override
  _i9.Future<List<String>> fetchSignInMethodsForEmail(String? email) => (super
          .noSuchMethod(Invocation.method(#fetchSignInMethodsForEmail, [email]),
              returnValue: Future<List<String>>.value(<String>[]))
      as _i9.Future<List<String>>);
  @override
  _i9.Future<_i6.UserCredential> getRedirectResult() =>
      (super.noSuchMethod(Invocation.method(#getRedirectResult, []),
              returnValue:
                  Future<_i6.UserCredential>.value(_FakeUserCredential_4()))
          as _i9.Future<_i6.UserCredential>);
  @override
  bool isSignInWithEmailLink(String? emailLink) => (super.noSuchMethod(
      Invocation.method(#isSignInWithEmailLink, [emailLink]),
      returnValue: false) as bool);
  @override
  _i9.Stream<_i6.User?> authStateChanges() =>
      (super.noSuchMethod(Invocation.method(#authStateChanges, []),
          returnValue: Stream<_i6.User?>.empty()) as _i9.Stream<_i6.User?>);
  @override
  _i9.Stream<_i6.User?> idTokenChanges() =>
      (super.noSuchMethod(Invocation.method(#idTokenChanges, []),
          returnValue: Stream<_i6.User?>.empty()) as _i9.Stream<_i6.User?>);
  @override
  _i9.Stream<_i6.User?> userChanges() =>
      (super.noSuchMethod(Invocation.method(#userChanges, []),
          returnValue: Stream<_i6.User?>.empty()) as _i9.Stream<_i6.User?>);
  @override
  _i9.Future<void> sendPasswordResetEmail(
          {String? email, _i5.ActionCodeSettings? actionCodeSettings}) =>
      (super.noSuchMethod(
          Invocation.method(#sendPasswordResetEmail, [],
              {#email: email, #actionCodeSettings: actionCodeSettings}),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i9.Future<void>);
  @override
  _i9.Future<void> sendSignInLinkToEmail(
          {String? email, _i5.ActionCodeSettings? actionCodeSettings}) =>
      (super.noSuchMethod(
          Invocation.method(#sendSignInLinkToEmail, [],
              {#email: email, #actionCodeSettings: actionCodeSettings}),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i9.Future<void>);
  @override
  _i9.Future<void> setLanguageCode(String? languageCode) =>
      (super.noSuchMethod(Invocation.method(#setLanguageCode, [languageCode]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i9.Future<void>);
  @override
  _i9.Future<void> setSettings(
          {bool? appVerificationDisabledForTesting,
          String? userAccessGroup,
          String? phoneNumber,
          String? smsCode,
          bool? forceRecaptchaFlow}) =>
      (super.noSuchMethod(
          Invocation.method(#setSettings, [], {
            #appVerificationDisabledForTesting:
                appVerificationDisabledForTesting,
            #userAccessGroup: userAccessGroup,
            #phoneNumber: phoneNumber,
            #smsCode: smsCode,
            #forceRecaptchaFlow: forceRecaptchaFlow
          }),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i9.Future<void>);
  @override
  _i9.Future<void> setPersistence(_i5.Persistence? persistence) =>
      (super.noSuchMethod(Invocation.method(#setPersistence, [persistence]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i9.Future<void>);
  @override
  _i9.Future<_i6.UserCredential> signInAnonymously() =>
      (super.noSuchMethod(Invocation.method(#signInAnonymously, []),
              returnValue:
                  Future<_i6.UserCredential>.value(_FakeUserCredential_4()))
          as _i9.Future<_i6.UserCredential>);
  @override
  _i9.Future<_i6.UserCredential> signInWithCredential(
          _i5.AuthCredential? credential) =>
      (super.noSuchMethod(
              Invocation.method(#signInWithCredential, [credential]),
              returnValue:
                  Future<_i6.UserCredential>.value(_FakeUserCredential_4()))
          as _i9.Future<_i6.UserCredential>);
  @override
  _i9.Future<_i6.UserCredential> signInWithCustomToken(String? token) =>
      (super.noSuchMethod(Invocation.method(#signInWithCustomToken, [token]),
              returnValue:
                  Future<_i6.UserCredential>.value(_FakeUserCredential_4()))
          as _i9.Future<_i6.UserCredential>);
  @override
  _i9.Future<_i6.UserCredential> signInWithEmailAndPassword(
          {String? email, String? password}) =>
      (super.noSuchMethod(
              Invocation.method(#signInWithEmailAndPassword, [],
                  {#email: email, #password: password}),
              returnValue:
                  Future<_i6.UserCredential>.value(_FakeUserCredential_4()))
          as _i9.Future<_i6.UserCredential>);
  @override
  _i9.Future<_i6.UserCredential> signInWithEmailLink(
          {String? email, String? emailLink}) =>
      (super.noSuchMethod(
          Invocation.method(
              #signInWithEmailLink, [], {#email: email, #emailLink: emailLink}),
          returnValue:
              Future<_i6.UserCredential>.value(_FakeUserCredential_4())) as _i9
          .Future<_i6.UserCredential>);
  @override
  _i9.Future<_i6.ConfirmationResult> signInWithPhoneNumber(String? phoneNumber,
          [_i6.RecaptchaVerifier? verifier]) =>
      (super.noSuchMethod(
          Invocation.method(#signInWithPhoneNumber, [phoneNumber, verifier]),
          returnValue: Future<_i6.ConfirmationResult>.value(
              _FakeConfirmationResult_5())) as _i9
          .Future<_i6.ConfirmationResult>);
  @override
  _i9.Future<_i6.UserCredential> signInWithPopup(_i5.AuthProvider? provider) =>
      (super.noSuchMethod(Invocation.method(#signInWithPopup, [provider]),
              returnValue:
                  Future<_i6.UserCredential>.value(_FakeUserCredential_4()))
          as _i9.Future<_i6.UserCredential>);
  @override
  _i9.Future<void> signInWithRedirect(_i5.AuthProvider? provider) =>
      (super.noSuchMethod(Invocation.method(#signInWithRedirect, [provider]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i9.Future<void>);
  @override
  _i9.Future<void> signOut() =>
      (super.noSuchMethod(Invocation.method(#signOut, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i9.Future<void>);
  @override
  _i9.Future<String> verifyPasswordResetCode(String? code) =>
      (super.noSuchMethod(Invocation.method(#verifyPasswordResetCode, [code]),
          returnValue: Future<String>.value('')) as _i9.Future<String>);
  @override
  _i9.Future<void> verifyPhoneNumber(
          {String? phoneNumber,
          _i5.PhoneVerificationCompleted? verificationCompleted,
          _i5.PhoneVerificationFailed? verificationFailed,
          _i5.PhoneCodeSent? codeSent,
          _i5.PhoneCodeAutoRetrievalTimeout? codeAutoRetrievalTimeout,
          String? autoRetrievedSmsCodeForTesting,
          Duration? timeout = const Duration(seconds: 30),
          int? forceResendingToken}) =>
      (super.noSuchMethod(
          Invocation.method(#verifyPhoneNumber, [], {
            #phoneNumber: phoneNumber,
            #verificationCompleted: verificationCompleted,
            #verificationFailed: verificationFailed,
            #codeSent: codeSent,
            #codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
            #autoRetrievedSmsCodeForTesting: autoRetrievedSmsCodeForTesting,
            #timeout: timeout,
            #forceResendingToken: forceResendingToken
          }),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i9.Future<void>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [User].
///
/// See the documentation for Mockito's code generation for more information.
class MockUser extends _i1.Mock implements _i6.User {
  MockUser() {
    _i1.throwOnMissingStub(this);
  }

  @override
  bool get emailVerified =>
      (super.noSuchMethod(Invocation.getter(#emailVerified), returnValue: false)
          as bool);
  @override
  bool get isAnonymous =>
      (super.noSuchMethod(Invocation.getter(#isAnonymous), returnValue: false)
          as bool);
  @override
  _i5.UserMetadata get metadata =>
      (super.noSuchMethod(Invocation.getter(#metadata),
          returnValue: _FakeUserMetadata_6()) as _i5.UserMetadata);
  @override
  List<_i5.UserInfo> get providerData =>
      (super.noSuchMethod(Invocation.getter(#providerData),
          returnValue: <_i5.UserInfo>[]) as List<_i5.UserInfo>);
  @override
  String get uid =>
      (super.noSuchMethod(Invocation.getter(#uid), returnValue: '') as String);
  @override
  _i9.Future<void> delete() =>
      (super.noSuchMethod(Invocation.method(#delete, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i9.Future<void>);
  @override
  _i9.Future<String> getIdToken([bool? forceRefresh = false]) =>
      (super.noSuchMethod(Invocation.method(#getIdToken, [forceRefresh]),
          returnValue: Future<String>.value('')) as _i9.Future<String>);
  @override
  _i9.Future<_i5.IdTokenResult> getIdTokenResult(
          [bool? forceRefresh = false]) =>
      (super.noSuchMethod(Invocation.method(#getIdTokenResult, [forceRefresh]),
              returnValue:
                  Future<_i5.IdTokenResult>.value(_FakeIdTokenResult_7()))
          as _i9.Future<_i5.IdTokenResult>);
  @override
  _i9.Future<_i6.UserCredential> linkWithCredential(
          _i5.AuthCredential? credential) =>
      (super.noSuchMethod(Invocation.method(#linkWithCredential, [credential]),
              returnValue:
                  Future<_i6.UserCredential>.value(_FakeUserCredential_4()))
          as _i9.Future<_i6.UserCredential>);
  @override
  _i9.Future<_i6.UserCredential> linkWithPopup(_i5.AuthProvider? provider) =>
      (super.noSuchMethod(Invocation.method(#linkWithPopup, [provider]),
              returnValue:
                  Future<_i6.UserCredential>.value(_FakeUserCredential_4()))
          as _i9.Future<_i6.UserCredential>);
  @override
  _i9.Future<_i6.ConfirmationResult> linkWithPhoneNumber(String? phoneNumber,
          [_i6.RecaptchaVerifier? verifier]) =>
      (super.noSuchMethod(
              Invocation.method(#linkWithPhoneNumber, [phoneNumber, verifier]),
              returnValue: Future<_i6.ConfirmationResult>.value(
                  _FakeConfirmationResult_5()))
          as _i9.Future<_i6.ConfirmationResult>);
  @override
  _i9.Future<_i6.UserCredential> reauthenticateWithCredential(
          _i5.AuthCredential? credential) =>
      (super.noSuchMethod(
              Invocation.method(#reauthenticateWithCredential, [credential]),
              returnValue:
                  Future<_i6.UserCredential>.value(_FakeUserCredential_4()))
          as _i9.Future<_i6.UserCredential>);
  @override
  _i9.Future<void> reload() =>
      (super.noSuchMethod(Invocation.method(#reload, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i9.Future<void>);
  @override
  _i9.Future<void> sendEmailVerification(
          [_i5.ActionCodeSettings? actionCodeSettings]) =>
      (super.noSuchMethod(
          Invocation.method(#sendEmailVerification, [actionCodeSettings]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i9.Future<void>);
  @override
  _i9.Future<_i6.User> unlink(String? providerId) =>
      (super.noSuchMethod(Invocation.method(#unlink, [providerId]),
              returnValue: Future<_i6.User>.value(_FakeUser_8()))
          as _i9.Future<_i6.User>);
  @override
  _i9.Future<void> updateEmail(String? newEmail) =>
      (super.noSuchMethod(Invocation.method(#updateEmail, [newEmail]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i9.Future<void>);
  @override
  _i9.Future<void> updatePassword(String? newPassword) =>
      (super.noSuchMethod(Invocation.method(#updatePassword, [newPassword]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i9.Future<void>);
  @override
  _i9.Future<void> updatePhoneNumber(
          _i5.PhoneAuthCredential? phoneCredential) =>
      (super.noSuchMethod(
          Invocation.method(#updatePhoneNumber, [phoneCredential]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i9.Future<void>);
  @override
  _i9.Future<void> updateDisplayName(String? displayName) =>
      (super.noSuchMethod(Invocation.method(#updateDisplayName, [displayName]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i9.Future<void>);
  @override
  _i9.Future<void> updatePhotoURL(String? photoURL) =>
      (super.noSuchMethod(Invocation.method(#updatePhotoURL, [photoURL]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i9.Future<void>);
  @override
  _i9.Future<void> updateProfile({String? displayName, String? photoURL}) =>
      (super.noSuchMethod(
          Invocation.method(#updateProfile, [],
              {#displayName: displayName, #photoURL: photoURL}),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i9.Future<void>);
  @override
  _i9.Future<void> verifyBeforeUpdateEmail(String? newEmail,
          [_i5.ActionCodeSettings? actionCodeSettings]) =>
      (super.noSuchMethod(
          Invocation.method(
              #verifyBeforeUpdateEmail, [newEmail, actionCodeSettings]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i9.Future<void>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [UserCredential].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserCredential extends _i1.Mock implements _i6.UserCredential {
  MockUserCredential() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String toString() => super.toString();
}

/// A class which mocks [GoogleSignIn].
///
/// See the documentation for Mockito's code generation for more information.
class MockGoogleSignIn extends _i1.Mock implements _i7.GoogleSignIn {
  MockGoogleSignIn() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i13.SignInOption get signInOption =>
      (super.noSuchMethod(Invocation.getter(#signInOption),
          returnValue: _i13.SignInOption.standard) as _i13.SignInOption);
  @override
  List<String> get scopes =>
      (super.noSuchMethod(Invocation.getter(#scopes), returnValue: <String>[])
          as List<String>);
  @override
  _i9.Stream<_i7.GoogleSignInAccount?> get onCurrentUserChanged =>
      (super.noSuchMethod(Invocation.getter(#onCurrentUserChanged),
              returnValue: Stream<_i7.GoogleSignInAccount?>.empty())
          as _i9.Stream<_i7.GoogleSignInAccount?>);
  @override
  _i9.Future<_i7.GoogleSignInAccount?> signInSilently(
          {bool? suppressErrors = true, bool? reAuthenticate = false}) =>
      (super.noSuchMethod(
              Invocation.method(#signInSilently, [], {
                #suppressErrors: suppressErrors,
                #reAuthenticate: reAuthenticate
              }),
              returnValue: Future<_i7.GoogleSignInAccount?>.value())
          as _i9.Future<_i7.GoogleSignInAccount?>);
  @override
  _i9.Future<bool> isSignedIn() =>
      (super.noSuchMethod(Invocation.method(#isSignedIn, []),
          returnValue: Future<bool>.value(false)) as _i9.Future<bool>);
  @override
  _i9.Future<_i7.GoogleSignInAccount?> signIn() =>
      (super.noSuchMethod(Invocation.method(#signIn, []),
              returnValue: Future<_i7.GoogleSignInAccount?>.value())
          as _i9.Future<_i7.GoogleSignInAccount?>);
  @override
  _i9.Future<_i7.GoogleSignInAccount?> signOut() =>
      (super.noSuchMethod(Invocation.method(#signOut, []),
              returnValue: Future<_i7.GoogleSignInAccount?>.value())
          as _i9.Future<_i7.GoogleSignInAccount?>);
  @override
  _i9.Future<_i7.GoogleSignInAccount?> disconnect() =>
      (super.noSuchMethod(Invocation.method(#disconnect, []),
              returnValue: Future<_i7.GoogleSignInAccount?>.value())
          as _i9.Future<_i7.GoogleSignInAccount?>);
  @override
  _i9.Future<bool> requestScopes(List<String>? scopes) =>
      (super.noSuchMethod(Invocation.method(#requestScopes, [scopes]),
          returnValue: Future<bool>.value(false)) as _i9.Future<bool>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [GoogleSignInAccount].
///
/// See the documentation for Mockito's code generation for more information.
class MockGoogleSignInAccount extends _i1.Mock
    implements _i7.GoogleSignInAccount {
  MockGoogleSignInAccount() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get email =>
      (super.noSuchMethod(Invocation.getter(#email), returnValue: '')
          as String);
  @override
  String get id =>
      (super.noSuchMethod(Invocation.getter(#id), returnValue: '') as String);
  @override
  _i9.Future<_i7.GoogleSignInAuthentication> get authentication =>
      (super.noSuchMethod(Invocation.getter(#authentication),
              returnValue: Future<_i7.GoogleSignInAuthentication>.value(
                  _FakeGoogleSignInAuthentication_9()))
          as _i9.Future<_i7.GoogleSignInAuthentication>);
  @override
  _i9.Future<Map<String, String>> get authHeaders => (super.noSuchMethod(
          Invocation.getter(#authHeaders),
          returnValue: Future<Map<String, String>>.value(<String, String>{}))
      as _i9.Future<Map<String, String>>);
  @override
  _i9.Future<void> clearAuthCache() =>
      (super.noSuchMethod(Invocation.method(#clearAuthCache, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i9.Future<void>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [GoogleSignInAuthentication].
///
/// See the documentation for Mockito's code generation for more information.
class MockGoogleSignInAuthentication extends _i1.Mock
    implements _i7.GoogleSignInAuthentication {
  MockGoogleSignInAuthentication() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String toString() => super.toString();
}
