
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gmail_alarm/utils/gmail_app_util.dart';
import 'package:gmail_alarm/base/base_view.dart';
import 'package:gmail_alarm/utils/locator.dart';
import 'package:gmail_alarm/utils/routes.dart';
import 'package:gmail_alarm/utils/view_state.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'View_Model/gmail_label_view_model.dart';
import 'model/google_auth_client.dart';

// Exception 'DetailedApiRequestError' is defined in _discoveryapis_commons.dart
// import 'package:googleapis/accessapproval/v1.dart';
import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as _discoveryapis_commons;


class GmailLabelScreen extends StatefulWidget {
  @override
  _GmailLabelScreenState createState() => _GmailLabelScreenState();
}

class _GmailLabelScreenState extends State<GmailLabelScreen> {
  //How to use GlobalKey: https://stackoverflow.com/questions/56280736/alertdialog-without-context-in-flutter
  GlobalKey<FormState> _userLoginFormKey = GlobalKey();
  BannerAd? banner;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // final gLabelViewModel = Provider.of<GmailLabelViewModel>(context);
    final gLabelViewModel = locator<GmailLabelViewModel>();
    final adState = gLabelViewModel.adState;
    adState!.adMobInitStatus.then((status){
      setState(() {
        banner = BannerAd(
            adUnitId: adState.bannerAdUnitId,
            size: AdSize.banner,
            listener: adState.adListner,
            request: AdRequest()
        )..load(); //.. Returns the object it was called on instead the result of the call
      });
    });
  }


  @override
  Widget build(BuildContext context) {
      return BaseView<GmailLabelViewModel>(
          onModelReady: (model) async {
            model.state = ViewState.Busy;
            debugPrint('_GmailLabelScreenState called with $model');
            try {
              // if(kDebugMode) throw _discoveryapis_commons.DetailedApiRequestError(666, "Test error");
              await model.loadLabels();
              model.state = ViewState.Idle;
            } on _discoveryapis_commons.DetailedApiRequestError catch (dare) {
              model.exception = dare;
              model.state = ViewState.Idle;
            }
          },
          builder: (context, model, build) {
            return buildScaffold(context, model);
          });
  }

  Widget buildScaffold(BuildContext context, GmailLabelViewModel model) {
    if (model.labels.isNotEmpty) {
      return WillPopScope(
          child: Scaffold(
            appBar: AppBar(title: Text('Mail Alarm'), actions: [
              Switch(
                  value: model.alarmOn,
                  activeColor: Color.fromARGB(0, 255, 255, 255),
                  onChanged: (value) {
                    GMailAppUtil.switchOnChange(value: value);
                    setState(() {});
                  }),
              IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    // Navigator.of(context).pushNamedAndRemoveUntil(Routes.SETTINGS, (Route<dynamic> route) => false);
                    Navigator.of(context).pushNamed(Routes.SETTINGS);
                  })
            ]),

            //Adding ads
            body: Column(
              children: [
                Expanded(child: _buildLabels(model)),
                if (banner == null)
                  SizedBox(height: 50)
                else
                  Container(
                    height: 50,
                    child: AdWidget(ad: banner!),
                  )
              ],
            ),
          ),
          onWillPop: () async {
            return false;
          });
    }

    if (model.exception == null) {
      return Scaffold(
        appBar: AppBar(
            title: Text('Mail Alarm'),
            actions: [
              IconButton(icon: Icon(Icons.settings),
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.SETTINGS);
                })]),
        body: buildLoadingWidget(),
      );
    } else {
      return Scaffold(
          appBar: AppBar(
              title: Text('Mail Alarm'),
              actions: [
                IconButton(icon: Icon(Icons.settings),
                  onPressed: () {
                    Navigator.of(context).pushNamed(Routes.SETTINGS);
                  })]),
          body: buildErrorWidget(model.exception!));
    }
  }


  Widget _buildLabels(GmailLabelViewModel model) {
    return ListView.builder(
        itemCount: (model.numberOfLabels * 2) - 1,
        padding: EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();
          switch (i) {
            case 0 : return _buildLabelRow(i, model);
            default: return _buildLabelRow(i ~/ 2, model);
          }
        });
  }

  Widget _buildLabelRow(int i, GmailLabelViewModel model) {
    //debugPrint('[gmail_label_screen] building label for $i : ${model.labelAt(i)}');
    var label = model.labelAt(i);
    var alreadySaved = model.alreadySaved(label);
    return ListTile(
      title: Text(label,style: TextStyle(fontSize: 18.0)),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        if (alreadySaved) {
          model.removeLabelFromFavs(label);
        } else {
          model.addLabelToFavs(label);
        }
      },
    );
  }

  Widget buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const <Widget>[
          SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(),
          ),
          Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text('Loading Labels...')),
        ],
      ),
    );
  }

  Widget buildErrorWidget(Exception error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(top: 16, right: 16, bottom: 16, left: 16),
              child: Text('Error loading labels: $error\nYou will be logged out.\nTry Logging in later')),
          Padding(
              padding: EdgeInsets.only(top: 16, right: 16, bottom: 16, left: 16),
              child: ElevatedButton(
                onPressed: () {
                  GoogleAuthClient gac = locator<GoogleAuthClient>();
                  gac.logout();
                  GmailLabelViewModel gvm = locator<GmailLabelViewModel>();
                  gvm.clearLabels();
                  GMailAppUtil.deleteSavedLabels();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      Routes.USER_LOGIN, ModalRoute.withName('/'));
                },
                child: const Text('OK', style: TextStyle(fontSize: 20)),
              ))
        ],
      ),
    );
  }
} // _GmailLabelScreenState