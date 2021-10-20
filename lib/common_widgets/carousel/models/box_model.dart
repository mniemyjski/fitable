import 'dart:typed_data';

class Box {
  final String url;
  final Uint8List uint8List;
  final bool isVideo;
  final bool isEdit;

  Box({this.url = '', this.uint8List, this.isVideo = false, this.isEdit = false});

  static List<Box> transform(List<String> urls) {
    List<Box> boxes = [];
    for (String element in urls) {
      boxes.add(Box(url: element));
    }
    return boxes;
  }

  Box copyWith({
    String url,
    Uint8List uint8List,
    bool isVideo,
    bool isEdit,
  }) {
    if ((url == null || identical(url, this.url)) &&
        (uint8List == null || identical(uint8List, this.uint8List)) &&
        (isVideo == null || identical(isVideo, this.isVideo)) &&
        (isEdit == null || identical(isEdit, this.isEdit))) {
      return this;
    }

    return new Box(
      url: url ?? this.url,
      uint8List: uint8List ?? this.uint8List,
      isVideo: isVideo ?? this.isVideo,
      isEdit: isEdit ?? this.isEdit,
    );
  }
}
