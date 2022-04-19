import 'package:google_mobile_ads/google_mobile_ads.dart';

class AddmobService {
  static String get bannerAdUnitId => "ca-app-pub-3683671396124442/4713008692";
  static String get testbannerAdUnitId =>
      "ca-app-pub-3940256099942544/6300978111";
  static initialize() {
    if (MobileAds.instance == null) {
      MobileAds.instance.initialize();
    }
  }

  static BannerAd createBannerAdd() {
    return BannerAd(
        size: AdSize.banner,
        adUnitId: testbannerAdUnitId,
        request: AdRequest(),
        listener: BannerAdListener(
            onAdClosed: (ad) {
              ad.dispose();
            },
            onAdFailedToLoad: (ad, error) {
              ad.dispose();
            },
            onAdLoaded: (ad) {},
            onAdOpened: (ad) {}));
  }
}
