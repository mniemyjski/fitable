import 'dart:typed_data';

import 'package:flutter/material.dart';

class CustomAvatar extends StatelessWidget {
  final Uint8List? uint8list;
  final double radius;

  const CustomAvatar({Key? key, this.uint8list, this.radius = 55}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
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
              size: radius * 2,
              color: Colors.white,
            ),
    );
  }
}
