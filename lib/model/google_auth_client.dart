import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart' as gSignIn;
import 'package:googleapis/gmail/v1.dart'; //GmailApi
import 'package:googleapis/oauth2/v2.dart'; //Oauth2Api
import 'package:mockito/annotations.dart';


abstract class GoogleAuthClientIF {
  GoogleAuthClientIF get instance;
  Future<Map<String,String>> login();
  void logout();
  Future<User?> loginUser();
}


class GoogleAuthClient extends http.BaseClient implements GoogleAuthClientIF {
  http.Client _httpClient = new http.Client();

  static late GoogleSignIn _googleSignIn;

  static late FirebaseAuth _auth;

  User? _user;

  GoogleAuthClient._privateConstructor();
  static dynamic _statusCallBack;

  static final GoogleAuthClient _instance = GoogleAuthClient._internal();
  static dynamic _mockInstance;
  GoogleAuthClient._internal();
  factory GoogleAuthClient({dynamic mock, dynamic statusDisplayCallBack, FirebaseAuth? firebase, GoogleSignIn? signIn}){
    _mockInstance = mock;
    _statusCallBack = statusDisplayCallBack;
    _auth = firebase == null ? FirebaseAuth.instance : firebase;
    _googleSignIn = signIn == null ? GoogleSignIn.standard(scopes:[GmailApi.gmailReadonlyScope]) : signIn;
    return _instance;
  }

  // needs 'return' from multi-line getters
  GoogleAuthClientIF get instance {
    if(_mockInstance == null) return _instance;
    debugPrint('_mockInstance:$_mockInstance');
    return _mockInstance;
  }

  @visibleForTesting
  static set mockInstance(GoogleAuthClient gac) => _mockInstance = gac;

  @visibleForTesting
  set mockHttpClient(http.Client client) => _httpClient = client;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    try {
      gSignIn.GoogleSignInAccount? _account = await _googleSignIn.signInSilently(suppressErrors: false);
      var headers = await _account!.authHeaders;
      return _httpClient.send(request..headers.addAll(headers));
    } catch (error) {
      var headers = await login();
      return _httpClient.send(request..headers.addAll(headers));
    }
  }


  Future<Map<String,String>> login() async {
    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    if (googleSignInAccount != null) {
      GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      UserCredential authResult = await _auth.signInWithCredential(credential);

      _user = authResult.user;
      assert(_user != null);
      assert(!_user!.isAnonymous);
      assert(await _user!.getIdToken() != null);

      User currentUser = await _auth.currentUser!;
      assert(_user!.uid == currentUser.uid);
      return googleSignInAccount.authHeaders;
    } else {
      debugPrint('googleSignInAccount is null');
    }
    throw Exception('Login failed');
  }

  Future<void> logout() async {
    _googleSignIn.signOut();
  }

  Future<User?> loginUser() async {
    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    if (googleSignInAccount != null) {
      GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      UserCredential authResult = await _auth.signInWithCredential(credential);
      _user = authResult.user;
      assert(_user != null);
      assert(!_user!.isAnonymous);
      assert(await _user!.getIdToken() != null);
      User currentUser = await _auth.currentUser!;
      assert(_user!.uid == currentUser.uid);
      return _user;
    } else {
      debugPrint('googleSignInAccount is null');
    }
    return _user;
  }
}