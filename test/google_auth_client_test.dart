import 'dart:convert';

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:gmail_alarm/model/google_auth_client.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:google_sign_in/google_sign_in.dart' as gSignIn;

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'google_auth_client_test.mocks.dart';

@GenerateMocks([http.Client])
@GenerateMocks([firebase.AuthCredential])
@GenerateMocks([firebase.FirebaseAuth])
@GenerateMocks([firebase.User])
@GenerateMocks([firebase.UserCredential])
@GenerateMocks([gSignIn.GoogleSignIn])
@GenerateMocks([gSignIn.GoogleSignInAccount])
@GenerateMocks([gSignIn.GoogleSignInAuthentication])


/**
 * To generate mocks, run in the terminal:
 *  gmail_alarm$>flutter pub run build_runner build
 */
void main() {

  group('login', () {
    test('returns a Map of tokens if login completes successfully', () async {
      final clientMock = MockClient();
      final firebaseAuthMock = MockFirebaseAuth();
      final firebaseUserMock = MockUser();
      final firebaseAuthCredentialMock = MockAuthCredential();
      final firebaseUserCredentialMock = MockUserCredential();
      final googleSignInMock = MockGoogleSignIn();
      final googleSignInAccountMock = MockGoogleSignInAccount();
      final googleSignInAuthenticationMock = MockGoogleSignInAuthentication();

      final authenticatedHeaders = <String, String>{"Authorization": "Bearer accessToken","X-Goog-AuthUser": "0",};

      GoogleAuthClient gac = GoogleAuthClient(firebase:firebaseAuthMock, signIn:googleSignInMock);
      gac.mockHttpClient = clientMock;

      // firebase.AuthCredential credential = firebase.AuthCredential(providerId: "google.com", signInMethod: "google.com", token: null);
      OAuthCredential credential = firebase.GoogleAuthProvider.credential (idToken:'idToken', accessToken:'accessToken');
      debugPrint('$credential');
      firebase.UserCredential? userCredential;

      when(firebaseUserMock.uid)
          .thenAnswer((realInvocation) => "UserID");
      when(firebaseUserMock.isAnonymous)
          .thenAnswer((realInvocation) => false);

      when(firebaseUserMock.getIdToken())
          .thenAnswer((realInvocation) => Future.value("IDToken"));

      when(firebaseUserCredentialMock.user)
          .thenAnswer((realInvocation) => firebaseUserMock);

      when(firebaseAuthMock.currentUser)
          .thenAnswer((realInvocation)  => firebaseUserMock);
      when(firebaseAuthMock.signInWithCredential(any))
      // when(firebaseAuthMock.signInWithCredential(credential))  // <-- this does not match, seems like it uses simple == for comparison,
	  // which will fail, https://www.technicalfeeder.com/2021/09/dart-comparing-two-objects-how-to-deep-equal/
          // .thenAnswer((realInvocation) async => Future.value(userCredential));
          .thenAnswer((realInvocation) async {

            // Does not print the object
            debugPrint('realInvocation = ${inspect(realInvocation)}');

            // https://stackoverflow.com/a/64815566 --> does not work: Converting object to an encodable object failed: Instance of '_Invocation'
            // Map jsonMapped = json.decode(json.encode(realInvocation));
            // // Using JsonEncoder for spacing
            // JsonEncoder encoder = new JsonEncoder.withIndent('  ');
            // // encode it to string
            // String prettyPrint = encoder.convert(jsonMapped);
            // // print or debugPrint your object
            // debugPrint(prettyPrint);

            debugPrint('realInvocation.positionalArguments[0] == credential: ${realInvocation.positionalArguments[0] == credential}');
            assert(realInvocation.positionalArguments[0] != credential);
            assert((realInvocation.positionalArguments[0] as AuthCredential).providerId == credential.providerId);
            assert((realInvocation.positionalArguments[0] as AuthCredential).signInMethod == credential.signInMethod);
            return firebaseUserCredentialMock;
      });

      when(googleSignInAuthenticationMock.accessToken)
          .thenAnswer((realInvocation) => "accessToken");
      when(googleSignInAuthenticationMock.idToken)
          .thenAnswer((realInvocation) => "idToken");

      when(googleSignInAccountMock.authentication)
          .thenAnswer((realInvocation) async => googleSignInAuthenticationMock);
      when(googleSignInAccountMock.authHeaders)
          .thenAnswer((realInvocation) async => Future.value(authenticatedHeaders));

      when(googleSignInMock.signIn())
          .thenAnswer((realInvocation) async => googleSignInAccountMock);

      // Use Mockito to return a successful response when it calls the provided http.Client.
      when(clientMock
          .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1')))
          .thenAnswer((_) async =>
          http.Response('{"userId": 1, "id": 2, "title": "mock"}', 200));

      // expect(await fetchAlbum(client), isA<Album>());
      expect(await gac.login(), equals(authenticatedHeaders));;
    });
  }); // group()
}
