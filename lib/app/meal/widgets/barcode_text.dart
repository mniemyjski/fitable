import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BarcodeText extends StatelessWidget {
  final String barcode;

  const BarcodeText(this.barcode, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 8, left: 5, right: 5, bottom: 8),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(12),
        ),
        child: BarcodeWidget(
          barcode: Barcode.ean13(drawEndChar: true),
          data: barcode,
          width: 400,
          height: 80,
        ));
  }
}