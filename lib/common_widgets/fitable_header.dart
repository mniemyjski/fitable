import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FitableHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: RichText(
            text: TextSpan(style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 180), children: [
          TextSpan(
            text: 'Fit',
            style: GoogleFonts.markaziText(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: 'able',
            style: GoogleFonts.markaziText(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
          ),
        ])),
      ),
    );
  }
}
