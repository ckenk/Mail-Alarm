
import 'package:flutter/material.dart';
import 'package:gmail_alarm/View_Model/settings_view_model.dart';
import 'package:gmail_alarm/utils/gmail_app_util.dart';
import 'package:gmail_alarm/utils/locator.dart';
import 'package:gmail_alarm/utils/routes.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'View_Model/gmail_label_view_model.dart';
import 'base/base_view.dart';
import 'model/google_auth_client.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  BannerAd? banner;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // final gLabelViewModel = Provider.of<GmailLabelViewModel>(context);
    final gLabelViewModel = locator<GmailLabelViewModelIF>();
    final adState = gLabelViewModel.adState;
    if(adState != null) {
      adState.adMobInitStatus.then((status) {
        setState(() {
          banner = BannerAd(
              adUnitId: adState.bannerAdUnitId,
              size: AdSize.banner,
              listener: adState.adListner,
              request: AdRequest()
          )
            ..load(); //.. Returns the object it was called on instead the result of the call
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<SettingsViewModel> (
        onModelReady: (model) {},
        builder: (context, model, build) {
          return buildScaffold(context, model);
        });
  }

  Widget buildScaffold(BuildContext context, SettingsViewModel model) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Mail Alarm'),
      ),

      body: Column(
        children: [
          Expanded(child: buildSwitchPane(context, model)),
          Align (
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              child: const Text('Log out', style: TextStyle(fontSize: 20)),
              style: ElevatedButton.styleFrom(
                  primary: Colors.blue, onPrimary: Colors.white,
                  onSurface: Colors.grey, elevation: 5),
              onPressed: () {
                performLogout();
                // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {return LoginScreen();}), ModalRoute.withName('/'));
                Navigator.of(context).pushNamedAndRemoveUntil(Routes.USER_LOGIN, ModalRoute.withName('/'));
              },
            ),
          ),
          if(banner == null)
            SizedBox(height: 50)
          else
            Container(
              height: 50,
              child: AdWidget(ad: banner!),
            )
        ],),
    );
  }

  Widget buildSwitchPane(BuildContext context, SettingsViewModel model) {
    return SwitchListTile(
      title: const Text('Alarm'),
      value: model.alarmOn,
      onChanged: (bool value) {
        GMailAppUtil.switchOnChange(value: value);
      },
      secondary: const Icon(Icons.alarm_outlined),
    );
  }

  void performLogout() {
    var gac = locator<GoogleAuthClientIF>();
    gac.logout();
    var gvm = locator<GmailLabelViewModelIF>();
    gvm.clearLabels();
    GMailAppUtil.deleteSavedLabels();
  }
}