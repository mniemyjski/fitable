import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:fitable/common_widgets/carousel/models/box_model.dart';
import 'package:fitable/common_widgets/carousel/view_models/carousel_view_model.dart';
import 'package:fitable/common_widgets/custom_icon_button.dart';
import 'package:fitable/common_widgets/image_render.dart';
import 'package:fitable/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class TileBox extends StatefulWidget {
  final Box box;

  const TileBox(this.box);

  @override
  _TileBoxState createState() => _TileBoxState();
}

class _TileBoxState extends State<TileBox> {
  YoutubePlayerController controller;

  @override
  void initState() {
    if (widget.box.isVideo) {
      controller = YoutubePlayerController(
        initialVideoId: widget.box.url,
        params: YoutubePlayerParams(
          showControls: true,
          showFullscreenButton: true,
          autoPlay: false,
          mute: false,
        ),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _buttonList() {
      if (!widget.box.isEdit) return [Container()];
      return [
        CustomIconButton(
          buttonColor: Colors.grey.withOpacity(0.5),
          icon: Icons.upload_rounded,
          onPressed: () => context.read(providerCarouselViewModel).addImage(),
        ),
        if (widget.box.url != null) ...[
          SizedBox(width: 25),
          CustomIconButton(
            buttonColor: Colors.grey.withOpacity(0.5),
            icon: Icons.crop,
            onPressed: () => context.read(providerCarouselViewModel).cropImage(context, widget.box.url),
          ),
        ],
        SizedBox(width: 25),
        CustomIconButton(
          buttonColor: Colors.grey.withOpacity(0.5),
          icon: Icons.delete,
          onPressed: () => context.read(providerCarouselViewModel).removeImage(),
        ),
      ];
    }

    if (widget.box.isVideo)
      return Stack(
        children: [
          YoutubePlayerIFrame(
            controller: controller,
            // aspectRatio: 16 / 9,
          ),
        ],
      );

    return Container(
      height: 500,
      child: Container(
        child: Stack(
          children: <Widget>[
            imageRender(url: widget.box.url, network: !widget.box.isEdit),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buttonList(),
              ),
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color.fromARGB(200, 0, 0, 0), Color.fromARGB(0, 0, 0, 0)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
