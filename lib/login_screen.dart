import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gmail_alarm/View_Model/sign_in_view_model.dart';
import 'package:gmail_alarm/base/base_view.dart';
import 'package:gmail_alarm/model/google_auth_client.dart';
import 'package:gmail_alarm/utils/deviceSize.dart';
import 'package:gmail_alarm/utils/locator.dart';
// import 'package:gmail_alarm/utils/routeNames.dart';
import 'package:gmail_alarm/utils/routes.dart';
import 'package:gmail_alarm/utils/util.dart';
import 'package:gmail_alarm/utils/view_state.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginScreen extends StatefulWidget{
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{

  late DeviceSize deviceSize;

  static String SIGNIN_ERROR_DEFAULT_TEXT = 'Login Failed: ';
  static String signInErrorMessage = SIGNIN_ERROR_DEFAULT_TEXT;

  GlobalKey<FormState> _userLoginFormKey = GlobalKey();
  late User? _user;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  bool isSignedIn = false;
  bool google = false;


  @override
  Widget build(BuildContext context) {
    deviceSize = DeviceSize(
        size: MediaQuery.of(context).size,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        aspectRatio: MediaQuery.of(context).size.aspectRatio);

    GoogleAuthClient googleAuthClient = locator<GoogleAuthClient>();
    return BaseView<SignInViewModel> (
        onModelReady: (model) {
          debugPrint("[_LoginScreenState] onModelReady called");
        },
        builder: (context, model, build) {
          debugPrint("[_LoginScreenState] builder called");
          return buildWillPopScope(context, model, googleAuthClient);
        }
    );
  }


  Future<User?> signInWithGoogleClient(SignInViewModel model, GoogleAuthClient googleAuthClient) async {
    model.state = ViewState.Busy;
    try {
      _user = await googleAuthClient.loginUser();
    } on PlatformException catch(e)  {
      signInErrorMessage += "(1) ${e.code}:${e.message}";
      isSignedIn = false;
      print("[MailAlarm]:"+signInErrorMessage);
    } on Exception catch(e2)  {
      signInErrorMessage += "(2) ${e2.toString()}";
      isSignedIn = false;
      print("[MailAlarm]:"+signInErrorMessage);
    } catch (e3) {
      signInErrorMessage += "(3) ${e3.toString()}";
      isSignedIn = false;
      print("[MailAlarm]:"+signInErrorMessage);
    }

    model.state = ViewState.Idle;
    return _user;
  }


  Widget buildWillPopScope(context, SignInViewModel model, GoogleAuthClient googleAuthClient) {
    return WillPopScope(
      child: SafeArea(
        child: Scaffold(
          // backgroundColor: Color(0xFFE6E6E6), //background color of the loging screen
          // backgroundColor: Colors.white70, //background color of the loging screen
          backgroundColor: Colors.lightBlue, //background color of the loging screen
          body: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child:Column(
                  children: <Widget>[
                    //keeps the login box at the bottom
                    Container(height: deviceSize.height/2.4, width: deviceSize.width/3,),
                    Container(
                      alignment: Alignment.center,
                      child: Form(
                        key: _userLoginFormKey,
                        child: Padding(
                          padding: const EdgeInsets.only(top:15.0,bottom:15,left: 10,right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                            child: Column(
                              children: <Widget> [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  // padding: const EdgeInsets.only(top:15.0,right: 14,left: 14,bottom: 8),
                                  child: Text("Login",style:TextStyle(fontWeight: FontWeight.w800,fontSize: 25),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 0,right: 5,left: 5,bottom: 0),
                                  child:
                                TextFormField(
                                  textAlign: TextAlign.center,
                                  initialValue: "Sign in with A OAuth Provider",
                                  enabled: false,
                                  // controller: model.userIdController,
                                  style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold),
                                  cursorColor:Colors.black,
                                  keyboardType: TextInputType.emailAddress,),
                                ),
                                SizedBox(height: 16,),

                                createGoogleSignInButton2(model, googleAuthClient),

                                SizedBox(height: 5,),

                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(signInErrorMessage == SIGNIN_ERROR_DEFAULT_TEXT ? '' : signInErrorMessage,
                                    style:TextStyle(fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: Color(0xFFFF0000)),),
                                ),

                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: buildToS_PrivacyPolicyLinks(context),
                          ),
                              ],),
                          ),),
                      ),),
                  ],),
              ),

              model.state == ViewState.Busy
                  ? Utils.progressBar()
                  : Container(),
            ],
          ),
        ),
      ),
      onWillPop: () async { //prevents the app closure when user clicks on 'back button'
        return true;
      },
    );
  }

  Widget buildToS_PrivacyPolicyLinks(BuildContext context) {
    TextStyle defaultStyle = TextStyle(color: Colors.grey, fontSize: 12.0);
    TextStyle linkStyle = TextStyle(color: Colors.blue);
    return RichText(
      text: TextSpan(
        style: defaultStyle,
        children: <TextSpan>[
          TextSpan(text: 'By clicking Sign In, you agree to our '),
          TextSpan(
              text: 'Terms & Conditions',
              style: linkStyle,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  debugPrint('Terms of Conditions tapped');
                  _launchToSURL();
                }),
          TextSpan(text: ' and that you have read our '),
          TextSpan(
              text: 'Privacy Policy.',
              style: linkStyle,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  debugPrint('Privacy Policy tapped');
                  _launchPPSURL();
                }),
          TextSpan(
              text: 'Read the user guide.',
              style: linkStyle,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  debugPrint('Terms of Conditions tapped');
                  _launchUGSURL();
                }),
        ],
      ),
    );
  }

  InkWell createGoogleSignInButton(SignInViewModel model, GoogleAuthClient googleAuthClient) {
    return InkWell(
      child: Container(
          width: (deviceSize.width/4*3) - 50,
          height: deviceSize.height/18,
          margin: EdgeInsets.only(top: 25),
          decoration: BoxDecoration(
              // color:Colors.black
              // color:Colors.blueAccent
              color:Color(0xFF4285F4) //(`FF` for the alpha, `42` for the red, `85` for the green, and `F4` for the blue)
          ),
          child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: 55.0, width: 55.0,
                    decoration: BoxDecoration(
                      // image: DecorationImage(image: AssetImage('assets/google.jpg'), fit: BoxFit.cover),
                      image: DecorationImage(image: AssetImage('assets/btn_google_signin_dark_normal_tvdpi.9.png'), fit: BoxFit.cover),
                      // shape: BoxShape.circle,
                    ),
                  ),
                  Text('Sign in with Google', style: TextStyle(fontFamily: "Roboto Medium",fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white)),
                ],
              )
          )
      ),
      onTap: () { loginPressed (model, googleAuthClient); },
    );
  }

  InkWell createGoogleSignInButton2(SignInViewModel model, GoogleAuthClient googleAuthClient) {
    return InkWell(
      child: SignInButton(
        Buttons.GoogleDark,
        onPressed: () { loginPressed (model, googleAuthClient); },
      ),
    );
  }

  void loginPressed (SignInViewModel model, GoogleAuthClient googleAuthClient)  {
    try {
      signInWithGoogleClient(model, googleAuthClient).then((User? user) {
        if (user != null) {
          isSignedIn = true;
          model.clearAllModels();
          Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.LABELS, (Route<dynamic> route) => false);
        } else {
          signInErrorMessage += "null user";
          isSignedIn = false;
          print("[MailAlarm]:" + 'Sign in failed: user null');
        }
      });
    } on PlatformException catch (e) {
      signInErrorMessage += "(4) ${e.code}:${e.message}";
      isSignedIn = false;
      print("[MailAlarm]:" + signInErrorMessage);
    } on Exception catch (e2) {
      signInErrorMessage += "(5) ${e2.toString()}";
      isSignedIn = false;
      print("[MailAlarm]:" + signInErrorMessage);
    } catch (e3) {
      signInErrorMessage += "(6) ${e3.toString()}";
      isSignedIn = false;
      print("[MailAlarm]:" + signInErrorMessage);
    };
  }

  void _launchToSURL() async =>
      await canLaunch("https://gmail-alarm-project-363952874922.blogspot.com/2021/11/terms-conditions-updated-at-2021-11-09.html") ?
      await launch("https://gmail-alarm-project-363952874922.blogspot.com/2021/11/terms-conditions-updated-at-2021-11-09.html") :

      throw 'Could not launch Terms of Service';

  void _launchPPSURL() async =>
      await canLaunch("https://gmail-alarm-project-363952874922.blogspot.com/2021/11/privacy-policy-gmail-alarm-last-updated.html") ?
      await launch("https://gmail-alarm-project-363952874922.blogspot.com/2021/11/privacy-policy-gmail-alarm-last-updated.html") :
      throw 'Could not launch Privacy Policy';

  void _launchUGSURL() async =>
      await canLaunch("https://gmail-alarm-project-363952874922.blogspot.com/2021/11/quick-user-guide.html") ?
      await launch("https://gmail-alarm-project-363952874922.blogspot.com/2021/11/quick-user-guide.html") :
      throw 'Could not launch User Guide';
}
