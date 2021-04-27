import 'package:easy_localization/easy_localization.dart';
import 'package:fitable/app/account/models/preference_model.dart';
import 'package:fitable/app/media/view_models/image_slider_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class BoxVideo extends StatefulWidget {
  final String videoUrl;
  final Preference pref;

  const BoxVideo({Key key, this.videoUrl, @required this.pref}) : super(key: key);

  @override
  _BoxVideoState createState() => _BoxVideoState(videoUrl, pref);
}

class _BoxVideoState extends State<BoxVideo> {
  final String videoUrl;
  final Preference pref;

  _BoxVideoState(this.videoUrl, this.pref);

  @override
  void initState() {
    final model = context.read(providerImageSliderViewModel);

    model.controller = YoutubePlayerController(
      initialVideoId: videoUrl,
      params: YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
        autoPlay: pref.autoPlay,
        mute: pref.mute,
      ),
    );

    Future.delayed(Duration(seconds: 1), () {
      if (pref.autoPlay && videoUrl.isNotEmpty && videoUrl != null) model.videoId = videoUrl;
      super.initState();
    });
    super.initState();
  }

  _onPressed(BuildContext context) {
    final model = context.read(providerImageSliderViewModel);
    model.carouselController.nextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final model = watch(providerImageSliderViewModel);

      return Stack(
        children: [
          YoutubePlayerIFrame(
            controller: model.controller,
            // aspectRatio: 16 / 9,
          ),
          Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                  iconSize: 60,
                  icon: Icon(
                    Icons.navigate_next,
                    color: Colors.white,
                  ),
                  onPressed: () => _onPressed(context))),
        ],
      );
    });
  }
}
