import 'package:firebase_admob/firebase_admob.dart';

class Ads {
  BannerAd bannerAd;
  InterstitialAd myInterstitial;
  MobileAdTargetingInfo targetingInfo;

  Ads() {
   FirebaseAdMob.instance.initialize(appId: "ca-app-pub-2751513292355996~5195371220");
   this.myInterstitial = InterstitialAd(
     adUnitId: "ca-app-pub-2751513292355996/4309664960",
     targetingInfo: targetingInfo,
     listener: (MobileAdEvent event){
       print("InterstitialAd event is $event");
     }
   );

   this.bannerAd = BannerAd(
    //  adUnitId:  "ca-app-pub-2751513292355996/4309664960",
    adUnitId:  BannerAd.testAdUnitId,
    targetingInfo: targetingInfo,
    size: AdSize.smartBanner,
    listener: (MobileAdEvent ev) {
      print("BannerAd event is $ev");
    },
   );

   this.targetingInfo = MobileAdTargetingInfo(
     keywords: <String>['flutter', 'sanduiche', 'coxinha', 'sucos', 'doces', 'salgados'],
     childDirected: false,
     testDevices: <String>[]
   );
  }

  void click(){
    bannerAd
    ..load()
    ..show(
      anchorType: AnchorType.bottom,
      anchorOffset: 50
    );
  }
}