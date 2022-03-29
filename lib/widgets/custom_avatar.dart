import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitable/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CustomAvatar extends StatelessWidget {
  final Uint8List? uint8list;

  const CustomAvatar({Key? key, this.uint8list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 55,
      backgroundColor: Colors.black12,
      child: uint8list != null
          ? Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.green, width: 0.5),
                  image: DecorationImage(image: MemoryImage(uint8list!), fit: BoxFit.fill)),
            )
          : Icon(
              Icons.account_circle,
              size: 110,
              color: Colors.white,
            ),
    );
  }
}
