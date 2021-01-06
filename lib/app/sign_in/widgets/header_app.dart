import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

headerApp(BuildContext context) {
  Size screenSize = MediaQuery.of(context).size;

  return Center(
    child: Container(
      margin: const EdgeInsets.only(bottom: 0),
      child: RichText(
          text: TextSpan(
        style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: screenSize.width / 5),
        children: [
          TextSpan(
            text: 'Fit',
            style: GoogleFonts.markaziText(color: Colors.black87, fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: 'able',
            style: GoogleFonts.markaziText(color: Colors.blue[800], fontWeight: FontWeight.bold),
          ),
        ],
      )),
    ),
  );
}
