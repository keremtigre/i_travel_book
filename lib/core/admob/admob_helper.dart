import 'package:google_mobile_ads/google_mobile_ads.dart';

class AddmobService {
  static String get bannerAdUnitId => "ca-app-pub-9703444831349835/8769535717";
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
        adUnitId: bannerAdUnitId,
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
