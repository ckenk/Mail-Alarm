import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdState {
  late Future<InitializationStatus> adMobInitStatus;

  AdState(this.adMobInitStatus);

  String get bannerAdUnitId => Platform.isAndroid 
		? 'ca-app-pub-3940256099942544/6300978111'  //dummy/test banner ad unit id
		: throw UnimplementedError('Apple Adunit not setup');

  BannerAdListener get adListner => _adListener;

  final BannerAdListener _adListener = BannerAdListener(
      onAdLoaded: (ad) => print('Ad loaded: ${ad.adUnitId}'),
      onAdClosed: (ad) => print('Ad closed: ${ad.adUnitId}'),
      onAdFailedToLoad: (ad, error) => print('Ad failed to load: ${ad.adUnitId}, $error'),
      onAdOpened: (ad) => print('Ad loaded: ${ad.adUnitId}')
  );
}