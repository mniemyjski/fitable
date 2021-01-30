import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MonetizeAd extends StatefulWidget {
  @override
  _MonetizeAdState createState() => _MonetizeAdState();
}

class _MonetizeAdState extends State<MonetizeAd> {
  @override
  void initState() {
    if (defaultTargetPlatform == TargetPlatform.android) {
      FacebookAudienceNetwork.init(
        testingId: "1fc63a78-68f9-4ac1-8faa-6d3688d610aa", //optional
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return Container(
        height: 50,
        margin: EdgeInsets.only(top: 5, left: 10, right: 5),
        child: Column(
          children: [
            Container(
              child: FacebookBannerAd(
                placementId: "1366934306833619_1493484640845251",
                bannerSize: BannerSize.STANDARD,
                listener: (result, value) {
                  switch (result) {
                    case BannerAdResult.ERROR:
                      print("Monetize Error: $value");
                      break;
                    case BannerAdResult.LOADED:
                      print("Monetize load: $value");
                      break;
                    case BannerAdResult.CLICKED:
                      print("Monetize Clicked: $value");
                      break;
                    case BannerAdResult.LOGGING_IMPRESSION:
                      print("Monetize Logging Impression: $value");
                      break;
                  }
                },
              ),
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
