import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BarcodeText extends StatelessWidget {
  final String barcode;

  const BarcodeText(this.barcode, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 5, left: 5, right: 2),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: <Widget>[
            Text(barcode, style: GoogleFonts.libreBarcode39(textStyle: TextStyle(fontSize: 47))),
            Container(
              margin: EdgeInsets.only(top: 25),
              child: Text(barcode,
                  style: TextStyle(
                    fontSize: 36,
                    letterSpacing: 4.0,
                  )),
            ),
          ],
        ));
  }
}
