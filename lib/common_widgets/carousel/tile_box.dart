import 'package:fitable/common_widgets/carousel/models/box_model.dart';
import 'package:fitable/common_widgets/custom_icon_button.dart';
import 'package:fitable/common_widgets/carousel/image_render.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:logger/logger.dart';

class TileBox extends StatefulWidget {
  final Box box;
  final VoidCallback add;
  final VoidCallback crop;
  final VoidCallback remove;

  const TileBox({Key key, @required this.box, @required this.add, @required this.crop, @required this.remove}) : super(key: key);

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

  bool _showCropButton() {
    if (widget.box.url.isNotEmpty) {
      if (widget.box.url.substring(0, 4) == 'http') return false;
    }
    if (widget.box.uint8List == null) return false;
    return true;
  }

  bool _showRemoveButton() {
    if (widget.box.url.isNotEmpty) return true;
    if (widget.box.uint8List != null) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    _buttonList() {
      if (!widget.box.isEdit) return [Container()];
      return [
        CustomIconButton(
          buttonColor: Colors.grey.withOpacity(0.5),
          icon: Icons.upload_rounded,
          onPressed: widget.add,
        ),
        if (_showCropButton())
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: CustomIconButton(
              buttonColor: Colors.grey.withOpacity(0.5),
              icon: Icons.crop,
              onPressed: widget.crop,
            ),
          ),
        if (_showRemoveButton())
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: CustomIconButton(
              buttonColor: Colors.grey.withOpacity(0.5),
              icon: Icons.delete,
              onPressed: widget.remove,
            ),
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
            ImageRender(url: widget.box.url, uint8list: widget.box.uint8List),
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
