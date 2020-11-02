import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextCustom extends StatelessWidget {
  @override
  String _text;
  double _fontSize;

  TextCustom({@required String text, double fontSize}){
    _text = text;
    _fontSize = fontSize;
  }

  Widget build(BuildContext context) {
    return Text(
      "$_text",
      style: GoogleFonts.juliusSansOne(fontSize: _fontSize, color: Colors.white),
    );
  }
}
